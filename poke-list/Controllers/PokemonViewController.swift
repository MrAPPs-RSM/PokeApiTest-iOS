//
//  PokemonController.swift
//  poke-list
//
//  Created by Nicola Innocenti on 31/10/21.
//

import UIKit
import PureLayout

class PokemonViewController: BaseViewController {
    
    // MARK: - Layout
    
    var tblData: UITableView = {
        let tableView: UITableView!
        if #available(iOS 13.0, *) {
            tableView = UITableView(frame: .zero, style: .insetGrouped)
            tableView.contentInset.top = 16
        } else {
            tableView = UITableView(frame: .zero, style: .grouped)
        }
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - Variables
    
    private var viewModel: PokemonViewModel!
    private var dataSource: PokemonDataSource<Pokemon>!
    
    // MARK: - Initialization
    
    convenience init(pokemon: Pokemon) {
        self.init()
        self.viewModel = PokemonViewModel(pokemon: pokemon)
    }
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        createLayout()
        configureDataSource()
        configureFavoriteButton(isFavorite: viewModel.pokemon.isFavorite)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func createLayout() {
        view.addSubview(tblData)
        tblData.autoPinEdgesToSuperviewEdges()
    }
    
    func configureFavoriteButton(isFavorite: Bool) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: isFavorite ? "fill_heart".image : "empty_heart".image?.paint(with: .heart), style: .plain, target: self.viewModel, action: #selector(self.viewModel.onFavoritePress))
        self.navigationItem.rightBarButtonItem?.tintColor = isFavorite ? .red : .heart
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tblData.contentInset.left = UIDevice.isIpad ? UIDevice.isPortrait ? 100 : 200 : 0
        tblData.contentInset.right = UIDevice.isIpad ? UIDevice.isPortrait ? 100 : 200 : 0
    }
    
    // MARK: - Other Methods
    
    func configureDataSource() {
        dataSource = PokemonDataSource(tableView: tblData, pokemon: viewModel.pokemon)
        tblData.dataSource = dataSource
        
        viewModel.onFavoriteChange = {isFavorite in
            self.configureFavoriteButton(isFavorite: isFavorite)
        }
    }
}
