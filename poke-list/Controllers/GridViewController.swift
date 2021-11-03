//
//  GridViewController.swift
//  poke-list
//
//  Created by Nicola Innocenti on 03/11/21.
//

import UIKit
import PureLayout

class GridViewController: BaseViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Layout
    
    var grid: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.identifier)
        return collectionView
    }()
    
    // MARK: - Variables
    
    private let margin: CGFloat = 12.0
    private var columns: CGFloat = 2
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createLayout()
        updateColumns()
    }
    
    func createLayout() {
        view.addSubview(grid)
        grid.delegate = self
        grid.autoPinEdgesToSuperviewEdges()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        guard let flowLayout = grid.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        coordinator.animate(alongsideTransition: nil) { completion in
            self.updateColumns()
            flowLayout.invalidateLayout()
        }
    }
    
    func updateColumns() {
        columns = UIDevice.isIpad ? UIDevice.isPortrait ? 4 : 5 : 2
    }
    
    // MARK: - UICollectionViewFlowLayout Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - margin*(columns+1)) / columns, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
}
