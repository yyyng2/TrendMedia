//
//  BackupRestoreTableViewCell.swift
//  TrendMedia
//
//  Created by Y on 2022/08/25.
//

import UIKit

class BackupRestoreTableViewCell: UITableViewCell{
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    var dataSizeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = .white
        [titleLabel, dataSizeLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        let spacing = 8
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(contentView).inset(spacing)
            make.width.equalTo(100)
            make.centerY.equalTo(contentView)
            make.leadingMargin.top.equalTo(spacing)
        }
        
        dataSizeLabel.snp.makeConstraints { make in
            make.trailingMargin.equalTo(-spacing)
            make.bottom.equalTo(-spacing)
            make.trailing.equalTo(22).offset(-spacing)
        }
    }
}
