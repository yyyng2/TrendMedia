//
//  SearchTableViewCell.swift
//  TrendMedia
//
//  Created by Y on 2022/07/19.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var story: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellBackground: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
