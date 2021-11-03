//
//  FavoritesController.swift
//  poke-list
//
//  Created by Nicola Innocenti on 30/10/21.
//

import UIKit
import PureLayout

class FavoritesViewController: GridViewController {
    
    // MARK: - Variables
    
    private var viewModel: FavoritesViewModel!
    private var dataSource: CollectionDataSource<PokemonCell, Pokemon>!
    
    // MARK: - UIViewController Handlers

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "favorites".localized
        
        setupViewModel()
        configureDataSource()
    }
    
    // MARK: - UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = viewModel.data[indexPath.row]
        navigationController?.pushViewController(PokemonViewController(pokemon: pokemon), animated: true)
    }
    
    // MARK: - Other Methods
    
    func setupViewModel() {
        viewModel = FavoritesViewModel()
    }
    
    func configureDataSource() {
        dataSource = CollectionDataSource(collectionView: grid, cellIdentifier: PokemonCell.identifier, items: viewModel.data, configureCell: { (cell, pokemon, indexPath) in
            cell.configure(with: pokemon)
        })
        grid.dataSource = dataSource
    }
}
