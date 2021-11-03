//
//  PokemonDataSource.swift
//  poke-list
//
//  Created by Nicola Innocenti on 03/11/21.
//

import Foundation
import UIKit
import RealmSwift

class PokemonDataSource<T: Pokemon> : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var tableView: UITableView?
    private var notificationToken: NotificationToken?
    private var pokemon: Pokemon!
    private var higherStat: Int = 0
    
    init(tableView: UITableView?, pokemon: Pokemon) {
        super.init()
        self.tableView = tableView
        self.pokemon = pokemon
        self.tableView?.register(PokemonHeaderCell.self, forCellReuseIdentifier: PokemonHeaderCell.identifier)
        self.tableView?.register(PokemonStatCell.self, forCellReuseIdentifier: PokemonStatCell.identifier)
        self.tableView?.delegate = self
        observeChanges()
        
        do {
            let realm = try Realm()
            if let stat = realm.objects(PokemonStat.self).filter("baseValue > 100").sorted(byKeyPath: "baseValue", ascending: false).first {
                self.higherStat = stat.baseValue
            }
        } catch {
            print("[PokemonDataSource] Error retrieving higher stat: \(error.localizedDescription)")
        }
    }
    
    private let fromRow = {(row: Int) in return IndexPath(row: row, section: 0)}
    
    private func observeChanges() {
        self.notificationToken = self.pokemon.observe(on: nil, { changes in
            self.tableView?.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
            view.clipsToBounds = true
            let label = UILabel(frame: CGRect(x: 8, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            label.font = UIFont.medium(size: 14)
            label.text = "stats".localized.uppercased()
            label.textColor = .navBarTint
            view.addSubview(label)
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : pokemon.stats.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? UITableView.automaticDimension : 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonHeaderCell.identifier, for: indexPath) as! PokemonHeaderCell
            cell.configure(pokemon: pokemon)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonStatCell.identifier, for: indexPath) as! PokemonStatCell
            let stat = pokemon.stats[indexPath.row]
            cell.configure(stat: stat, higherStat: higherStat)
            return cell
        }
    }
}
