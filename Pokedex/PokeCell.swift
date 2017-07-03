//
//  PokeCell.swift
//  Pokedex
//
//  Created by Nishant on 03/07/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit

//function to add data to the collection view cell
class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    
    var pokemon: Pokemon!
    
    //to set corner radius as "5.0" for the UICollectionViewCells
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        pokeName.text = pokemon.name.capitalized
        pokeImage.image = UIImage(named: "\(pokemon.pokedexId)")
    
    }
}
