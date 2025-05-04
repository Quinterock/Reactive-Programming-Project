//
//  HeroTableViewCell.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 04/05/25.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

    @IBOutlet weak var heroImageView: UIImageView!
    
    @IBOutlet weak var heroTitleText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
