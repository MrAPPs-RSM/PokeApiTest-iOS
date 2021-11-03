//
//  PokemonListController.swift
//  poke-list
//
//  Created by Nicola Innocenti on 30/10/21.
//

import UIKit
import PureLayout

class HomeViewController: GridViewController, UISearchResultsUpdating {

    // MARK: - Variables
    
    private var viewModel: HomeViewModel!
    private var dataSource: CollectionDataSource<PokemonCell, Pokemon>!
    
    // MARK: - UIViewController Handlers

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "pokemons".localized
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "search".localized
        navigationItem.searchController = search
        
        setupViewModel()
        configureDataSource()
    }
    
    // MARK: - UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
        let pokemon = viewModel.data[indexPath.row]
        navigationController?.pushViewController(PokemonViewController(pokemon: pokemon), animated: true)
    }
    
    // MARK: - UISearchController Delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.search(text: searchController.searchBar.text)
        configureDataSource()
    }
    
    // MARK: - Other Methods
    
    func setupViewModel() {
        viewModel = HomeViewModel()
    }
    
    func configureDataSource() {
        dataSource = CollectionDataSource(collectionView: grid, cellIdentifier: PokemonCell.identifier, items: viewModel.data, configureCell: { (cell, pokemon, indexPath) in
            cell.configure(with: pokemon)
        })
        grid.dataSource = dataSource
    }
}
