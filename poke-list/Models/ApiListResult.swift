//
//  ApiListResult.swift
//  poke-list
//
//  Created by Nicola Innocenti on 31/10/21.
//

import Foundation
import ObjectMapper

class ApiListResultItem: NSObject, Mappable {
    var name: String = ""
    var url: String = ""
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        name       <- map["name"]
        url        <- map["url"]
    }
}

class ApiListResult: NSObject, ObjectMapper.Mappable {
    var count: Int = 0
    var next: String?
    var previous: String?
    var results: [ApiListResultItem] = []
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        count       <- map["count"]
        next        <- map["next"]
        previous    <- map["previous"]
        results     <- map["results"]
    }
    
    class func parse(fromJSON: JSON) -> ApiListResult? {
        return Mapper<ApiListResult>().map(JSON: fromJSON)
    }
}
