//
//  RequestScreenProtocols.swift
//  MVVM with RxSwift
//
//  Created by admin on 27.07.2021.
//

import RxSwift
import RxCocoa

protocol RequestScreenViewModelProtocol {
    func getInformation()
    func numberOfRowsInSection() -> Int
    func textForRow(indexPath: IndexPath) -> String
    var reloadDataEvent: Driver<Void> { get }
    var isLoadingEvent: Driver<Bool> { get }
    var segueEvent: Driver<RouterSegue> { get }
}

protocol RequestScreenModelProtocol {
    var arrayGif: [InformationAboutGif] { get set}
    func request(completion: @escaping (Void?,ErrorModel?) -> ()) 
}

