//
//  PokemonStatCell.swift
//  poke-list
//
//  Created by Nicola Innocenti on 03/11/21.
//

import UIKit
import PureLayout

class PokemonStatCell: UITableViewCell {
    
    // MARK: - Layout
    
    private var titleContainer: UIView = {
        let view = UIView()
        return view
    }()
    private var lblTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(size: 14)
        label.textColor = .navBarTint
        return label
    }()
    var typesContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private var viewProgress: UIView = {
        let view = UIView()
        return view
    }()
    private var valueContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.navBarTint.withAlphaComponent(0.2)
        return view
    }()
    private var lblValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(size: 15)
        label.textColor = .navBarTint
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Variables
    
    private var pokemonStat: PokemonStat!
    private var higherStat: Int!
    private let titleWidth: CGFloat = 140
    private let valueWidth: CGFloat = 50
    private var cntValueLeading: NSLayoutConstraint!
    
    // MARL: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Other Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calculateProgress()
    }
    
    private func createLayout() {
        selectionStyle = .none
        backgroundColor = .navBar
        
        addSubview(titleContainer)
        titleContainer.autoPinEdge(.leading, to: .leading, of: self)
        titleContainer.autoPinEdge(.top, to: .top, of: self)
        titleContainer.autoPinEdge(.bottom, to: .bottom, of: self)
        titleContainer.autoSetDimension(.width, toSize: titleWidth)
        
        titleContainer.addSubview(lblTitle)
        lblTitle.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        
        addSubview(viewProgress)
        viewProgress.autoPinEdge(toSuperviewEdge: .top)
        viewProgress.autoPinEdge(toSuperviewEdge: .bottom)
        viewProgress.autoPinEdge(.leading, to: .trailing, of: titleContainer)
        
        addSubview(valueContainer)
        valueContainer.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .leading)
        valueContainer.autoSetDimension(.width, toSize: valueWidth)
        cntValueLeading = valueContainer.autoPinEdge(.leading, to: .trailing, of: viewProgress, withOffset: 0)
        
        valueContainer.addSubview(lblValue)
        lblValue.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8))
    }
    
    private func calculateProgress() {
        if pokemonStat != nil {
            let percentage = CGFloat(pokemonStat.baseValue) / CGFloat(higherStat)
            let rightPercentage = percentage > 1 ? 1.0 : percentage
            let leading = (frame.size.width-titleWidth-valueWidth) * (1.0 - rightPercentage)
            cntValueLeading.constant = leading
        }
    }
    
    func configure(stat: PokemonStat, higherStat: Int) {
        self.pokemonStat = stat
        self.higherStat = higherStat
        viewProgress.backgroundColor = stat.stat?.color
        lblTitle.text = stat.stat?.translation
        titleContainer.backgroundColor = stat.stat?.color?.withAlphaComponent(0.6)
        lblValue.text = "\(stat.baseValue)"
    }
}
