//
//  CustomCell.swift
//  CollectionView with container view
//
//  Created by Pratik Gavit on 31/01/23.
//

import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.backgroundColor = .cyan
        mainView.layer.cornerRadius = 20
        mainView.clipsToBounds = true
    }

}
