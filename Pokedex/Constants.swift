//
//  Constants.swift
//  Pokedex
//
//  Created by Nishant on 05/07/17.
//  Copyright © 2017 rao. All rights reserved.
//

import Foundation

let BASE_URL = "https://pokeapi.co/"
let POKEMON_URL = "/api/v1/pokemon/"

//make sure that code is executed after network calls are completed
typealias downloadCompleted = () -> ()
