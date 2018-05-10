//
//  BaseDeeplink.swift
//  Alamofire
//
//  Created by poniavit on 10/5/2561 BE.
//

protocol DeeplinkHandler {
    func isMatchScheme(url:URL) -> Bool
    var type : String { get }
    var name : String { get }
}

extension DeeplinkHandler {
    
}
