//
//  Type.swift
//  poke-list
//
//  Created by Nicola Innocenti on 31/10/21.
//

import UIKit
import RealmSwift
import ObjectMapper

class PokemonType: Object, ObjectMapper.Mappable {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        id      <- map["id"]
        name    <- map["name"]
    }
    
    class func parse(fromJSON: JSON) -> PokemonType? {
        return Mapper<PokemonType>().map(JSON: fromJSON)
    }
    
    var color: UIColor? {
        return name.color
    }
}
