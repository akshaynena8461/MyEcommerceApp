//
//  CategoryCollectionViewCell.swift
//  MyEcommerceApplicationTask
//
//  Created by Akshay Nena on 19/07/25.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblcategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setborder(textfield: viewMain)
    }
    func setborder(textfield: UIView) {
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.layer.cornerRadius = 10
        textfield.clipsToBounds = false
    }
    

}
