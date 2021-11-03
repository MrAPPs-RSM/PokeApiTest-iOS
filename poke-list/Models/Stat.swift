//
//  Stat.swift
//  poke-list
//
//  Created by Nicola Innocenti on 03/11/21.
//

import UIKit
import RealmSwift
import ObjectMapper

class Stat: Object, ObjectMapper.Mappable {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var names = List<Translation>()
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        id      <- map["id"]
        name    <- map["name"]
    }
    
    var translation: String? {
        return names.first { translation in
            return translation.languageIsoCode == Locale.systemLanguage
        }?.value
    }
    
    var color: UIColor? {
        var statColor: UIColor?
        if let statType = StatType(rawValue: name) {
            switch statType {
                case .hp: statColor = .hp
                case .attack: statColor = .attack
                case .defense: statColor = .defense
                case .specialAttack: statColor = .specialAttack
                case .specialDefense: statColor = .specialDefense
                case .speed: statColor = .speed
                default: break
            }
        }
        return statColor
    }
    
    class func parse(fromJSON: JSON) -> Stat? {
        let stat = Mapper<Stat>().map(JSON: fromJSON)
        if let names = fromJSON["names"] as? [JSON] {
            for item in names {
                if let translation = Translation.parse(fromJSON: item) {
                    stat?.names.append(translation)
                }
            }
        }
        return stat
    }
}
