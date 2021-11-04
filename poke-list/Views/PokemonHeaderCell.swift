//
//  PokemonHeaderCell.swift
//  poke-list
//
//  Created by Nicola Innocenti on 03/11/21.
//

import UIKit

class PokemonHeaderCell: UITableViewCell {
    
    // MARK: - Layout
    
    private var spritesContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
    }()
    private var imgSpriteStandard: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private var imgSpriteShiny: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private var lblName: UILabel = {
        let label = UILabel()
        label.font = UIFont.semiBold(size: 30)
        label.textColor = .navBarTint
        label.textAlignment = .center
        return label
    }()
    private var typesContainer: TypesView = {
        let view = TypesView()
        return view
    }()
    
    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Other Methods
    
    private func createLayout() {
        selectionStyle = .none
        backgroundColor = .navBar
        
        addSubview(spritesContainer)
        spritesContainer.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), excludingEdge: .bottom)
        spritesContainer.autoSetDimension(.height, toSize: 170)
        
        spritesContainer.addSubview(imgSpriteStandard)
        imgSpriteStandard.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .right)
        
        spritesContainer.addSubview(imgSpriteShiny)
        imgSpriteShiny.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .left)
        imgSpriteShiny.autoPinEdge(.leading, to: .trailing, of: imgSpriteStandard, withOffset: 16)
        imgSpriteShiny.autoMatch(.width, to: .width, of: imgSpriteStandard)
        
        addSubview(lblName)
        lblName.autoAlignAxis(toSuperviewAxis: .vertical)
        lblName.autoPinEdge(.top, to: .bottom, of: spritesContainer, withOffset: 16)
        
        addSubview(typesContainer)
        typesContainer.autoPinEdge(.top, to: .bottom, of: lblName, withOffset: 16)
        typesContainer.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        typesContainer.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
    func configure(pokemon: Pokemon) {
        if let spriteStandard = pokemon.spriteFrontUrl, let spriteShiny = pokemon.spriteFrontShinyUrl {
            imgSpriteStandard.sd_setImage(with: URL(string: spriteStandard), completed: nil)
            imgSpriteShiny.sd_setImage(with: URL(string: spriteShiny), completed: nil)
        }
        lblName.text = pokemon.name.capitalized
        typesContainer.configure(pokemonTypeA: pokemon.typeA, pokemonTypeB: pokemon.typeB, style: .big)
    }
}
