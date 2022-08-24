//
//  Transition.swift
//  TrendMedia
//
//  Created by Y on 2022/08/24.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present //네비게이션 없이 present
        case presentNavigation //네비게이션 임베드 present
        case presentFullNavigation //네비게이션 풀스크린
        case push
    }
    //T, viewcontroller 내부 매개변수로 사용시 다른 인스턴스가 생성됨
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
        
        switch transitionStyle {
            
        case .present:
            self.present(viewController, animated: true)
            
        case .presentNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            self.present(navi, animated: true)
        
        case .presentFullNavigation:
            let navi = UINavigationController(rootViewController: viewController)
            navi.modalPresentationStyle = .fullScreen
            self.present(navi, animated: true)
            
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
