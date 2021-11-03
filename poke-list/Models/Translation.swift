//
//  Translation.swift
//  poke-list
//
//  Created by Nicola Innocenti on 01/11/21.
//

import UIKit
import RealmSwift
import ObjectMapper

class Translation: Object, Mappable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var languageIsoCode: String = ""
    @Persisted var value: String = ""
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        languageIsoCode <- map["language.name"]
        value           <- map["name"]
    }
    
    class func parse(fromJSON: JSON) -> Translation? {
        return Mapper<Translation>().map(JSON: fromJSON)
    }
}
