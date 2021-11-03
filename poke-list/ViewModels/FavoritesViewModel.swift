//
//  FavoritesViewModel.swift
//  poke-list
//
//  Created by Nicola Innocenti on 30/10/21.
//

import UIKit
import RealmSwift

class FavoritesViewModel: NSObject {
    var data: Results<Pokemon>!
    
    override init() {
        super.init()
        setup()
    }
    
    private func setup() {
        let realm = try! Realm()
        data = realm.objects(Pokemon.self).filter("isFavorite == 1").sorted(byKeyPath: "id", ascending: true)
    }
}
