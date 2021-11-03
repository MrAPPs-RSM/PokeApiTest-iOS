//
//  Pokemon.swift
//  poke-list
//
//  Created by Nicola Innocenti on 30/10/21.
//

import Foundation
import RealmSwift
import ObjectMapper

class Pokemon: Object, Mappable {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var order: Int = 0
    @Persisted var typeA: PokemonType?
    @Persisted var typeB: PokemonType?
    @Persisted var spriteFrontUrl: String?
    @Persisted var spriteFrontShinyUrl: String?
    @Persisted var isFavorite: Bool = false
    @Persisted var stats = List<PokemonStat>()
    
    override init() {
        super.init()
    }
    
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        id                      <- map["id"]
        name                    <- map["name"]
        order                   <- map["order"]
        spriteFrontUrl          <- map["sprites.front_default"]
        spriteFrontShinyUrl     <- map["sprites.front_shiny"]
    }
    
    class func parse(fromJSON: JSON) -> Pokemon? {
        let pokemon = Mapper<Pokemon>().map(JSON: fromJSON)
        do {
            let realm = try Realm()
            if let types = fromJSON["types"] as? [JSON] {
                if types.count == 1 {
                    if let contentA = types.first, let typeA = contentA["type"] as? JSON, let name = typeA["name"] as? String {
                        pokemon?.typeA = realm.objects(PokemonType.self).filter("name == '\(name)'").first
                    }
                } else if types.count == 2 {
                    if let contentA = types.first, let typeA = contentA["type"] as? JSON, let name = typeA["name"] as? String {
                        pokemon?.typeA = realm.objects(PokemonType.self).filter("name == '\(name)'").first
                    }
                    if let contentB = types.last, let typeB = contentB["type"] as? JSON, let name = typeB["name"] as? String {
                        pokemon?.typeB = realm.objects(PokemonType.self).filter("name == '\(name)'").first
                    }
                }
            }
            if let stats = fromJSON["stats"] as? [JSON] {
                for item in stats {
                    if let stat = PokemonStat.parse(fromJSON: item) {
                        pokemon?.stats.append(stat)
                    }
                }
            }
        } catch {
            print("[Pokemon] Error parsing pokemon details: \(error.localizedDescription)")
        }
        return pokemon
    }
}
