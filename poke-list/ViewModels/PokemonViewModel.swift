//
//  PokemonViewModel.swift
//  poke-list
//
//  Created by Nicola Innocenti on 03/11/21.
//

import UIKit
import RealmSwift

class PokemonViewModel: NSObject {
    var pokemon: Pokemon!
    var onFavoriteChange: (Bool) -> Void = { _ in }
    
    convenience init(pokemon: Pokemon) {
        self.init()
        self.pokemon = pokemon
        self.onFavoriteChange(pokemon.isFavorite)
    }
    
    @objc func onFavoritePress() {
        do {
            let realm = try Realm()
            try realm.write {
                let isFavorite = !pokemon.isFavorite
                pokemon.isFavorite = isFavorite
                self.onFavoriteChange(isFavorite)
            }
        } catch {
            print("[PokemonCell] Error changing favorite: \(error.localizedDescription)")
        }
    }
}
