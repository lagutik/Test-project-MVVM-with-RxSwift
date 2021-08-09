//
//  InformationAboutGif.swift
//  MVVM with RxSwift
//
//  Created by admin on 27.07.2021.
//

import ObjectMapper

struct ResponseFromTheServerAboutGif: Mappable {
    var data: [DataFromTheServer]
    
    init?(map: Map) {
        do {
            self.data = try map.value("data") as [DataFromTheServer]
        } catch {
            return nil
        }
    }
    
    mutating func mapping(map: Map) {
        data <- (map["data"])
    }
}

struct DataFromTheServer: Mappable {
    var images: Images
    
    init?(map: Map) {
        do {
            self.images = try map.value("images") as Images
        } catch {
            return nil
        }
    }
    
    mutating func mapping(map: Map) {
        images <- (map["images"])
    }
}

struct Images: Mappable {
    var original: InformationAboutGif
    
    init?(map: Map) {
        do {
            self.original = try map.value("original") as InformationAboutGif
        } catch {
            return nil
        }
    }
    
    mutating func mapping(map: Map) {
        original <- (map["original"])
    }
}

struct InformationAboutGif: Mappable {
    var height: String
    var width: String
    var url: String
    
    init?(map: Map) {
        do {
            self.height = try map.value("height") as String
            self.width = try map.value("width") as String
            self.url = try map.value("url") as String
        } catch {
            return nil
        }
    }
    
    mutating func mapping(map: Map) {
        height <- (map["height"])
        width  <- (map["width"])
        url    <- (map["url"])
    }
}
