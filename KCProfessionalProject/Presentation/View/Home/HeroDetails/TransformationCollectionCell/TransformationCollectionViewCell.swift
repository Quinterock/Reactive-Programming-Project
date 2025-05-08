//
//  TransformationCollectionViewCell.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 05/05/25.
//

import UIKit

class TransformationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var transformationImageView: UIImageView!
    
    @IBOutlet weak var transformationNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with transformation: TransformationsModel) {
            transformationNameLabel.text = transformation.name
            if let url = URL(string: transformation.photo) {
                transformationImageView.loadImageRemote(url: url)
            }
        }
}
