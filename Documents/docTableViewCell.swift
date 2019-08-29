//
//  docTableViewCell.swift
//  Documents
//
//  Created by Ryan Glascock on 8/29/19.
//  Copyright © 2019 Ryan Glascock. All rights reserved.
//

import UIKit

class docTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dateChangedLabel: UILabel!
    @IBOutlet weak var docDescription: UILabel!
    @IBOutlet weak var docTitleLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configureCell(doc: Doc) {
        self.docTitleLabel.text = doc.docName?.uppercased()
        self.docDescription.text = doc.docDescription
        
        //self.dateChangedLabel.text +
    }

}
