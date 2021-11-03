//
//  HomeViewModel.swift
//  poke-list
//
//  Created by Nicola Innocenti on 30/10/21.
//

import UIKit
import RealmSwift

class HomeViewModel: NSObject {
    var data: Results<Pokemon>!
    
    override init() {
        super.init()
        search(text: nil)
    }
    
    func search(text: String?) {
        let realm = try! Realm()
        if let query = text, query.trimmingCharacters(in: .whitespacesAndNewlines).count > 2 {
            data = realm.objects(Pokemon.self).filter("name CONTAINS[c] '\(query)'").sorted(byKeyPath: "id", ascending: true)
        } else {
            data = realm.objects(Pokemon.self).sorted(byKeyPath: "id", ascending: true)
        }
    }
}
