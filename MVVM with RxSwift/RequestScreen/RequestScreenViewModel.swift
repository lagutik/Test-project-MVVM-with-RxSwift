//
//  RequestScreenViewModel.swift
//  MVVM with RxSwift
//
//  Created by admin on 26.07.2021.
//

import Foundation
import RxSwift
import RxCocoa

class RequestScreenViewModel {
    private var model: RequestScreenModelProtocol
    private let reloadDataSubject = PublishSubject<Void>()
    let isLoading = ReplaySubject<Bool>.create(bufferSize: 1)
    let segueSubject = PublishSubject<RouterSegue>()
    
    init(model: RequestScreenModelProtocol) {
        self.model = model
    }
}

extension RequestScreenViewModel: RequestScreenViewModelProtocol {
    var reloadDataEvent: Driver<Void> {
        return reloadDataSubject.asDriver(onErrorDriveWith: .empty())
    }
    
    var segueEvent: Driver<RouterSegue> {
        return segueSubject.asDriver(onErrorDriveWith: .empty())
    }
    
    var isLoadingEvent: Driver<Bool> { isLoading.asDriver(onErrorDriveWith: .empty()) }
    
    func getInformation() {
        isLoading.onNext(true)
        model.request(completion: { [weak self] (response, error) in
            guard let self = self else { return }
            self.isLoading.onNext(false)
            if response != nil {
                self.reloadDataSubject.onNext(())
            } else {
                self.segueSubject.onNext(.alertMessage(error: .serverError))
            }
        })
    }
    
    func numberOfRowsInSection() -> Int {
        return model.arrayGif.count
    }
    
    func textForRow(indexPath: IndexPath) -> String {
        let textForRow = model.arrayGif[indexPath.row].url
        return textForRow
    }
}
