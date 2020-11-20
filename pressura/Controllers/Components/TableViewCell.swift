//
//  TableViewCell.swift
//  pressura
//
//  Created by Julio Gutierrez Briones on 19/11/20.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var reading: UIView!
    
    @IBOutlet weak var diastolicReading: UILabel!
    
    
    @IBOutlet weak var sistolicReading: UILabel!
    
    @IBOutlet weak var pulseReading: UILabel!
    
    @IBOutlet weak var creationDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.reading.clipsToBounds = true
        self.reading.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
        creationDate.font = UIFont.boldSystemFont(ofSize: 16)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
