//
//  TableViewCell.swift
//  WeatheriOSAssignment
//
//  Created by Madhuri Patil on 03/07/21.
//

import UIKit

class WeatherTabelCell: UITableViewCell {
    
    @IBOutlet weak var cityNamelabel: UILabel!
    @IBOutlet weak var tempabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
