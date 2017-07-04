//
//  ViewController.swift
//  Pokedex
//
//  Created by Nishant on 02/07/17.
//  Copyright © 2017 rao. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var musicPlayer: AVAudioPlayer!    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        //change "search" button to "done"
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initMusic()
    }
    
    //action for music button
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    //function to initialize "AVAudioPlayer"
    func initMusic() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
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
            let poke: Pokemon!
            
            if inSearchMode {
                
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)

            } else {
                
                poke = pokemon[indexPath.row]
                cell.configureCell(poke)

            }
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
            
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            
            return filteredPokemon.count
            
        } else
        {
            
            return pokemon.count
            
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    //function for search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            collectionView.reloadData()
            
            //hide software keyboard when searchbar is cleared
            view.endEditing(true)
            
        } else {
            
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemon.filter({ $0.name.range(of: lower) != nil})
            collectionView.reloadData()
            
        }
    }
    
    //hide keyboard when search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
}

