//
//  ErrorModel.swift
//  MVVM with RxSwift
//
//  Created by admin on 03.08.2021.
//

enum ErrorModel {
    case serverError
    
    var textError: String {
        switch self {
        case .serverError: return "Server Error"
        }
    }
}
