//
//  TypesView.swift
//  poke-list
//
//  Created by Nicola Innocenti on 03/11/21.
//

import UIKit

class TypesView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func createLayout() {
        backgroundColor = .clear
    }
    
    func configure(pokemonTypeA: PokemonType?, pokemonTypeB: PokemonType?, style: TypeSize) {
        removeSubviews()
        if let typeA = pokemonTypeA, let typeB = pokemonTypeB {
            let viewTypeA = TypeView()
            viewTypeA.configure(type: typeA, style: style)
            addSubview(viewTypeA)
            viewTypeA.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: .right)
            
            let viewTypeB = TypeView()
            viewTypeB.configure(type: typeB, style: style)
            addSubview(viewTypeB)
            viewTypeB.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: .left)
            viewTypeB.autoPinEdge(.leading, to: .trailing, of: viewTypeA, withOffset: 8)
            viewTypeB.autoMatch(.width, to: .width, of: viewTypeA)
        } else if let typeA = pokemonTypeA {
            let viewTypeA = TypeView()
            viewTypeA.configure(type: typeA, style: style)
            addSubview(viewTypeA)
            viewTypeA.autoPinEdgesToSuperviewEdges()
        }
    }
}
