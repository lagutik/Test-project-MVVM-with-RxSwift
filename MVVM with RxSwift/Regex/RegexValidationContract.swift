//
//  RegexValidationContract.swift
//  MVVM with RxSwift
//
//  Created by admin on 05.08.2021.
//

protocol RegexValidationProtocol {
    func validationText(text: String, type: RegexValidationType) -> Bool
}
