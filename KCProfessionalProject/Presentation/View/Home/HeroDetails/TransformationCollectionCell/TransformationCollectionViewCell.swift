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
    
    @IBOutlet weak var transformationDescriptionLabel: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with transformation: TransformationsModel) {
            transformationNameLabel.text = transformation.name
        transformationDescriptionLabel.text = transformation.description
        
            if let url = URL(string: transformation.photo) {
                transformationImageView.loadImageRemote(url: url)
            }
        }
}
