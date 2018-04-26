//
//  BaseResponse.swift
//  Base
//
//  Created by Ponlavit Larpeampaisarl on 4/26/18.
//

import Foundation

open class SimpleResponseModel : Decodable {
    public var message : String!
    public var status : UInt!
    
    public static func parse(withJson json:String!) -> SimpleResponseModel {
        let jsonData = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        return try! decoder.decode(self, from: jsonData)
    }
}
