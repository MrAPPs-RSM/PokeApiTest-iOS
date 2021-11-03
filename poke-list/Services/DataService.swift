//
//  DataService.swift
//  poke-list
//
//  Created by Nicola Innocenti on 31/10/21.
//

import UIKit
import RealmSwift

class DataService: NSObject {
    func fetchTypes(data: [JSON]) {
        do {
            var types = [PokemonType]()
            for typeData in data {
                if let type = PokemonType.parse(fromJSON: typeData) {
                    types.append(type)
                }
            }
            let realm = try Realm()
            try realm.write {
                realm.add(types, update: .all)
            }
        } catch {
            print("[DataService] Error saving pokemon types: \(error.localizedDescription)")
        }
    }
    
    func fetchPokemons(data: [JSON]) {
        do {
            var pokemons = [Pokemon]()
            for item in data {
                if let pokemon = Pokemon.parse(fromJSON: item) {
                    pokemons.append(pokemon)
                }
            }
            let realm = try Realm()
            try realm.write {
                realm.add(pokemons, update: .all)
            }
        } catch {
            print("[DataService] Error saving pokemons: \(error.localizedDescription)")
        }
    }
    
    func fetchStats(data: [JSON]) {
        do {
            var stats = [Stat]()
            for item in data {
                if let stat = Stat.parse(fromJSON: item) {
                    stats.append(stat)
                }
            }
            let realm = try Realm()
            try realm.write {
                realm.add(stats, update: .all)
            }
        } catch {
            print("[DataService] Error saving pokemons: \(error.localizedDescription)")
        }
    }
    
    func fetchPokemonDetail(data: JSON) {
        do {
            if let pokemon = Pokemon.parse(fromJSON: data) {
                let realm = try Realm()
                try realm.write {
                    realm.add(pokemon, update: .all)
                }
            }
        } catch {
            print("[DataService] Error saving pokemon details: \(error.localizedDescription)")
        }
    }
}
