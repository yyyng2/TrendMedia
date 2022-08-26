//
//  BackupRestoreView.swift
//  TrendMedia
//
//  Created by Y on 2022/08/25.
//

import UIKit

class BackupRestoreView: UIView{
    var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.register(BackupRestoreTableViewCell.self, forCellReuseIdentifier: BackupRestoreTableViewCell.reuseIdentifier)
        return view
    }()
    
    var backupButton: UIButton = {
        let button = UIButton()
        button.setTitle("백업", for: .normal)
        return button
    }()
    
    var restroeButton: UIButton = {
        let button = UIButton()
        button.setTitle("복구", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configureUI()
        setConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [backupButton, restroeButton, tableView].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .black
    }
        
    
    func setConstraints() {
        backupButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.centerX.equalTo(safeAreaLayoutGuide).multipliedBy(0.7)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        restroeButton.snp.makeConstraints { make in
            make.top.equalTo(backupButton.snp.top)
            make.left.equalTo(backupButton.snp.right)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backupButton.snp.bottom)
            make.left.right.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
 
    
}
