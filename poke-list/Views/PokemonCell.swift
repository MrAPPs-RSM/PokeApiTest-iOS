//
//  PokemonCell.swift
//  poke-list
//
//  Created by Nicola Innocenti on 30/10/21.
//

import UIKit
import SDWebImage
import RealmSwift

class PokemonCell: UICollectionViewCell {
    
    // MARK: - Layout
    
    var imgSprite: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var lblNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(size: 15)
        label.textColor = .navBarTint
        return label
    }()
    var lblName: UILabel = {
        let label = UILabel()
        label.font = UIFont.bold(size: 17)
        label.textColor = .navBarTint
        label.textAlignment = .center
        return label
    }()
    var typesContainer: TypesView = {
        let view = TypesView()
        return view
    }()
    var btnFavorite: UIButton = {
        let button = UIButton()
        return button
    }()
    
    // MARK: - Variables
    
    private var pokemon: Pokemon?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func createLayout() {
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.borderColor = UIColor.border.cgColor
        layer.borderWidth = 1
        backgroundColor = .clear
        contentView.backgroundColor = .navBar
        
        contentView.addSubview(imgSprite)
        imgSprite.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        imgSprite.autoPinEdge(toSuperviewEdge: .leading, withInset: 16, relation: .greaterThanOrEqual)
        imgSprite.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16, relation: .greaterThanOrEqual)
        imgSprite.autoAlignAxis(toSuperviewAxis: .vertical)
        
        contentView.addSubview(lblNumber)
        lblNumber.autoPinEdge(toSuperviewEdge: .leading, withInset: 12)
        lblNumber.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        
        contentView.addSubview(lblName)
        lblName.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        lblName.autoPinEdge(toSuperviewEdge: .trailing, withInset: 8)
        lblName.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
        
        contentView.addSubview(btnFavorite)
        btnFavorite.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        btnFavorite.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12)
        btnFavorite.autoSetDimensions(to: CGSize(width: 24, height: 24))
        btnFavorite.addTarget(self, action: #selector(onFavoritePress), for: .touchUpInside)
    }
    
    func configure(with pokemon: Pokemon) {
        self.pokemon = pokemon
        lblNumber.text = "#\(pokemon.id)"
        lblName.text = pokemon.name.capitalized
        btnFavorite.setImage(pokemon.isFavorite ? "fill_heart".image?.paint(with: .red) : "empty_heart".image?.paint(with: .heart), for: .normal)
        
        if let spriteUrl = pokemon.spriteFrontUrl {
            imgSprite.sd_setImage(with: URL(string: spriteUrl), completed: nil)
        } else {
            imgSprite.image = nil
        }
        
        typesContainer.removeFromSuperview()
        if pokemon.typeA != nil {
            contentView.addSubview(typesContainer)
            typesContainer.autoPinEdge(.bottom, to: .top, of: lblName, withOffset: -8)
            typesContainer.autoAlignAxis(toSuperviewAxis: .vertical)
            typesContainer.autoPinEdge(toSuperviewEdge: .leading, withInset: 4, relation: .greaterThanOrEqual)
            typesContainer.autoPinEdge(toSuperviewEdge: .trailing, withInset: 4, relation: .greaterThanOrEqual)
            imgSprite.autoPinEdge(toSuperviewEdge: .bottom, withInset: 54)
            typesContainer.configure(pokemonTypeA: pokemon.typeA, pokemonTypeB: pokemon.typeB, style: .small)
        } else {
            imgSprite.autoPinEdge(toSuperviewEdge: .bottom, withInset: 24)
        }
    }
    
    @objc private func onFavoritePress() {
        guard let pokemon = self.pokemon else { return }
        do {
            let realm = try Realm()
            try realm.write {
                pokemon.isFavorite = !pokemon.isFavorite
            }
        } catch {
            print("[PokemonCell] Error changing favorite: \(error.localizedDescription)")
        }
    }
}
