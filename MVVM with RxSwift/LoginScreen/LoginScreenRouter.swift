//
//  LoginScreenRouter.swift
//  MVVM with RxSwift
//
//  Created by admin on 03.08.2021.
//

import UIKit

class LoginScreenRouter {
    func presentVC(viewController: UIViewController, vcToPresent: UIViewController) {
        vcToPresent.modalPresentationStyle = .fullScreen
        viewController.present(vcToPresent, animated: true, completion: nil)
    }
}
