//
//  ServerRequest.swift
//  MVVM with RxSwift
//
//  Created by admin on 28.07.2021.
//

import Moya

enum GifServise {
    case search
}

extension GifServise: TargetType{
    var baseURL: URL {
        guard let baseURL = URL(string: Network.baseURL) else {
            return URL.init(target: self)
        }
        return baseURL
    }
    
    var path: String {
        return "/search"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: ["api_key" : Network.gifKey,
                                               "q" : Network.nameGifSearch],
                                  encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
}

struct Network {
    static let baseURL = "https://api.giphy.com/v1/gifs"
    static let gifKey = "yUQshQuEGxnOMme5L0gvO1visY2m5G7i"
    static let nameGifSearch = "smile"
}


