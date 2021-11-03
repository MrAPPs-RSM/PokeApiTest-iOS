//
//  TypeView.swift
//  poke-list
//
//  Created by Nicola Innocenti on 31/10/21.
//

import Foundation
import UIKit
import PureLayout

enum TypeSize {
    case small
    case big
}

class TypeView : UIView {
    var lblType: UILabel = {
        let label = UILabel()
        label.font = UIFont.semiBold(size: 14)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private var cntTypeWidth: NSLayoutConstraint!
    private var cntTypeHeight: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func createLayout() {
        clipsToBounds = true
        layer.cornerRadius = 4
        addSubview(lblType)
        cntTypeWidth = autoSetDimension(.width, toSize: 50, relation: .greaterThanOrEqual)
        cntTypeHeight = autoSetDimension(.width, toSize: 50, relation: .greaterThanOrEqual)
        lblType.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4))
    }
    
    func configure(type: PokemonType, style: TypeSize) {
        backgroundColor = type.color
        cntTypeWidth.constant = style == .small ? 50 : 90
        cntTypeHeight.constant = style == .small ? 30 : 50
        lblType.text = type.name.capitalized
        lblType.font = style == .small ? UIFont.semiBold(size: 14) : UIFont.semiBold(size: 17)
    }
}
