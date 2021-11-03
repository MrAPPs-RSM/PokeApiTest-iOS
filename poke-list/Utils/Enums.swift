//
//  Enums.swift
//  poke-list
//
//  Created by Nicola Innocenti on 30/10/21.
//

import Foundation

enum ApiEndpoints: String {
    case type = "type"
    case pokemon = "pokemon"
    case ability = "ability"
    case move = "move"
    case stat = "stat"
}

enum StatType: String {
    case hp = "hp"
    case attack = "attack"
    case defense = "defense"
    case specialAttack = "special-attack"
    case specialDefense = "special-defense"
    case speed = "speed"
    case accuracy = "accuracy"
    case evasion = "evasion"
}
