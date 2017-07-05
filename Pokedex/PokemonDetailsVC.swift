//
//  PokemonDetailsVC.swift
//  Pokedex
//
//  Created by Nishant on 04/07/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var evolutionLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "\(pokemon.pokedexId)")

        nameLabel.text = pokemon.name.capitalized
        mainImage.image = image
        currentEvoImage.image = image
        pokedexIdLabel.text = "\(pokemon.pokedexId)"
    
        //will only be called after network calls are completed
        pokemon.downloadPokemonData {
            
            self.updateUI()
        }

    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        
        typeLabel.text = pokemon.type
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        baseAttackLabel.text = pokemon.attack
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description
        
        if pokemon.nextEvolutionId == "" {
            
            evolutionLabel.text = "No Evolutions"
            nextEvoImage.isHidden = true
        } else {
            
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvolutionId)
            
            let str = "Next Evolution: \(pokemon.nextEvolutionName) - Lvl \(pokemon.nextEvolutionLevel)"
            evolutionLabel.text = str
        }
        
    }

}
