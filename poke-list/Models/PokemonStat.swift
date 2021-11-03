//
//  PokemonStat.swift
//  poke-list
//
//  Created by Nicola Innocenti on 03/11/21.
//

import UIKit
import RealmSwift
import ObjectMapper

class PokemonStat: Object, ObjectMapper.Mappable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var baseValue: Int = 0
    @Persisted var stat: Stat?
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        baseValue    <- map["base_stat"]
    }
    
    class func parse(fromJSON: JSON) -> PokemonStat? {
        let pokemonStat = Mapper<PokemonStat>().map(JSON: fromJSON)
        if let stat = fromJSON["stat"] as? JSON, let name = stat["name"] as? String {
            do {
                let realm = try Realm()
                pokemonStat?.stat = realm.objects(Stat.self).filter("name == '\(name)'").first
            } catch {
                print("[PokemonStat] Error assigning stat to pokemon: \(error.localizedDescription)")
            }
        }
        return pokemonStat
    }
}
