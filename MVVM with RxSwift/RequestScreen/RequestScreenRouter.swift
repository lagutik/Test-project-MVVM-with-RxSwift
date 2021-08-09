//
//  RequestRouter.swift
//  MVVM with RxSwift
//
//  Created by admin on 28.07.2021.
//

import Foundation
import UIKit

enum RouterSegue {
    case alertMessage(error: ErrorModel)
    case close
}

class RequestScreenRouter {
    func perform(_ segue: RouterSegue, viewController: UIViewController) {
        switch segue {
        case .alertMessage(let error):
            openAlert(error: error, viewController: viewController)
        case .close:
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}

private extension RequestScreenRouter {
    func openAlert(error: ErrorModel, viewController: UIViewController) {
        let alertController = UIAlertController(title: error.textError , message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ОK", style: .cancel, handler: nil))
        viewController.present(alertController, animated: true)
    }
}




