//
//  Pokemon.swift
//  Pokedex
//
//  Created by Nishant on 03/07/17.
//  Copyright © 2017 rao. All rights reserved.
//

import Foundation

//class to hold pokemon data
class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name:String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
}
