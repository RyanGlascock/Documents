//
//  ListTableViewController.swift
//  Documents
//
//  Created by Ryan Glascock on 8/28/19.
//  Copyright © 2019 Ryan Glascock. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController {

    var docs = [Doc]()
    var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        retrieveDocs()
    }
 

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return docs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "docTableViewCell", for: indexPath) as! docTableViewCell

        let doc: Doc = docs[indexPath.row]
        cell.configureCell(doc: doc)
        

        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     
        return true
    }
  

   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
       
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
    func retrieveDocs() {
        managedObjectContext?.perform {
            
            self.fetchDocsFromCoreData { (docs) in
                if let docs = docs {
                    self.docs = docs
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    func fetchDocsFromCoreData(completion: @escaping ([Doc]?) -> Void) {
        managedObjectContext?.perform {
            var docs = [Doc]()
            let request: NSFetchRequest<Doc> = Doc.fetchRequest()
            
            do {
                docs = try self.managedObjectContext!.fetch(request)
                completion(docs)
            }
            catch {
                print("Could not find document from Core Data:\(error.localizedDescription)")
            }
        }
    }
    


}
