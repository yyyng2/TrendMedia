//
//  UIViewController+Extension.swift
//  TrendMedia
//
//  Created by Y on 2022/07/19.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setBackgroundColor(){
        view.backgroundColor = .orange
    }
    
    func showAlert(title: String, buttonTitle: String){
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: buttonTitle, style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}
