//
//  ShoppingTableViewCell.swift
//  TrendMedia
//
//  Created by Y on 2022/07/19.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBackground: UIView!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure(){
        cellBackground.layer.cornerRadius = 6
        cellBackground.clipsToBounds = true
        cellBackground.backgroundColor = .systemGray6
        checkBoxButton.setTitle(nil, for: .normal)
        starButton.setTitle(nil, for: .normal)
    }
    
    
}
