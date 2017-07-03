//
//  ViewController.swift
//  Pokedex
//
//  Created by Nishant on 02/07/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var pokemon = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        parsePokemonCSV()
    }
    
    //functoin to parse csv
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                //add new elements to "pokemon" array
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    //functions implemented for UICollectionView cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            //configure UICollectionViewCells using "pokemon" array elements
            let poke = pokemon[indexPath.row]
            cell.configureCell(poke)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }

}

