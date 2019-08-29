//
//  DocumentViewController.swift
//  Documents
//
//  Created by Ryan Glascock on 8/28/19.
//  Copyright © 2019 Ryan Glascock. All rights reserved.
//

import UIKit
import CoreData


class DocumentViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UITextViewDelegate{

    @IBOutlet var docInfoView: UIView!
    
    @IBOutlet weak var docNameLabel: UITextField!
    @IBOutlet weak var docDescriptionLabel: UITextView!
    
    
    
    var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    }
    
    var docsFetchedResultsController: NSFetchedResultsController<Doc>!
    var docs = [Doc]()
    var doc: Doc?
    var isExisting = false
    var indexPath: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let doc = doc {
            docNameLabel.text = doc.docName
            docDescriptionLabel.text = doc.docDescription
            //image
            
        }
        if docNameLabel.text != "" {
            isExisting = true
        }
        docNameLabel.delegate = self
        docDescriptionLabel.delegate = self
    }
    
    func saveToCoreData(completion: @escaping ()->Void){
        managedObjectContext!.perform {
            do {
                try self.managedObjectContext?.save()
                completion()
                print("Documend saved to core data.")
            }
            catch let error {
                print ("Could not save document to CoreData: \(error.localizedDescription)")
            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n"){
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Note Description..") {
            textView.text = ""
        }
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        if (isExisting == false){
            let docName = docNameLabel.text
            let docDescription = docDescriptionLabel.text
            
            if let moc = managedObjectContext {
                let doc = Doc(context: moc)
                
                doc.docName = docName
                doc.docDescription = docDescription
                
                saveToCoreData {
                    let isPresentingInAddDocMode = self.presentingViewController is UINavigationController
                    
                    if isPresentingInAddDocMode {
                        self.dismiss(animated: true, completion: nil)
                    }
                        
                    else {
                        self.navigationController!.popViewController(animated: true)
                    }
                }
            }
            
        }
            
        else if (isExisting == true) {
            let doc = self.doc
            
            let managedObject = doc
            managedObject!.setValue(docNameLabel.text, forKey: "docName")
            managedObject!.setValue(docDescriptionLabel, forKey: "docDescription")
            
            do {
                try context.save()
                
                let isPresentingInAddDocMode = self.presentingViewController is UINavigationController
                
                if isPresentingInAddDocMode {
                    self.dismiss(animated: true, completion: nil)
                }
                    
                else {
                    self.navigationController!.popViewController(animated: true)
                }
            }
            catch{
                print("Failed to update existing document.")
            }
        }
    }
    
}



