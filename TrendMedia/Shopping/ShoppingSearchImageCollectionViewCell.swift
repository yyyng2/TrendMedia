//
//  ShoppingSearchImageCollectionViewCell.swift
//  TrendMedia
//
//  Created by Y on 2022/08/24.
//

import UIKit
import Kingfisher

class ShoppingSearchImageCollectionViewCell: UICollectionViewCell {
    
    let searchImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = UIColor.white
        return view
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.addSubview(searchImageView)
    }
    
    func setConstraints() {
        searchImageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func setImage(data: String) {
        let url = URL(string: data)
        searchImageView.kf.setImage(with: url)
    }
}
