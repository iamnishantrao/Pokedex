//
//  Pokemon.swift
//  Pokedex
//
//  Created by Nishant on 03/07/17.
//  Copyright © 2017 rao. All rights reserved.
//

import Foundation
import Alamofire

//class to hold pokemon data
class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _pokemonURL: String!
  
    
    init(name:String, pokedexId: Int) {
        
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(BASE_URL)\(POKEMON_URL)\(self.pokedexId)/"
    }

    var name: String {
        
        return _name
    }
    
    var pokedexId: Int {
        
        return _pokedexId
    }
    
    var description: String {
        
        if _description == nil {
            
            _description = ""
        }
        
        return _description
    }
    
    var type: String {
        
        if _type == nil {
            
            _type = ""
        }
        
        return _type
    }
    
    var defense: String {
        
        if _defense == nil {
            
            _defense = ""
        }
        
        return _defense
    }
    
    var height: String {
        
        if _height == nil {
            
            _height = ""
        }
        
        return _height
    }
    
    var weight: String {
        
        if _weight == nil {
            
            _weight = ""
        }
        
        return _weight
    }
    
    var attack: String {
        
        if _attack == nil {
            
            _attack = ""
        }
        
        return _attack
    }
    
    var nextEvolutionText: String {
        
        if _nextEvolutionText == nil {
            
            _nextEvolutionText = ""
        }
        
        return _nextEvolutionText
    }

    
    //download data using Alamofire
    func downloadPokemonData(completed: @escaping downloadCompleted) {
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let dictionary = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dictionary["weight"] as? String {
                    
                    self._weight = weight
                }
                
                if let height = dictionary["height"] as? String {
                    
                    self._height = height
                }
                 
                if let attack = dictionary["attack"] as? Int {
                    
                    self._attack = "\(attack)"
                }
                
                if let defense = dictionary["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                }
                
                if let types = dictionary["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            
                            if let name = types[x]["name"] {
                                
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                } else {
                    
                    self._type = ""
                }

            }
            completed()
        }
        
    }

}
