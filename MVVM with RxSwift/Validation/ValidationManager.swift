//
//  ValidationManager.swift
//  MVVM with RxSwift
//
//  Created by admin on 02.08.2021.
//

class ValidationManager: ValidationManagerProtocol {
    func validation(text: String) -> String {
        guard text.count != 0 else {
            return ("Введите символы")
        }
        return ("")
    }
}
