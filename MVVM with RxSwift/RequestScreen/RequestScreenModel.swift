//
//  RequestScreenModel.swift
//  MVVM with RxSwift
//
//  Created by admin on 26.07.2021.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import ObjectMapper

class RequestScreenModel: RequestScreenModelProtocol {
    var arrayGif: [InformationAboutGif] = []
    
    func request(completion: @escaping (Void?,ErrorModel?) -> ()) {
        let provider = MoyaProvider<GifServise>(plugins: [NetworkLoggerPlugin()])
        
        provider.request(.search){ [weak self] result in
            guard let self = self else { return }
            self.arrayGif = []
            
            switch result {
            case .failure:
                completion(nil, ErrorModel.serverError)
            case .success(let response):
                guard response.statusCode != 404 else { 
                    return completion(nil, ErrorModel.serverError)
                }
                
                do {
                    let gifs =  Mapper<ResponseFromTheServerAboutGif>().map(JSONString: try response.mapString())
                    guard let array = gifs else { return }
                    for element in array.data {
                        self.arrayGif.append(element.images.original)
                    }
                    completion((),nil)
                } catch {
                    completion(nil, ErrorModel.serverError)
                }
            }
        }
    }
}

