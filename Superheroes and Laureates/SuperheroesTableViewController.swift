//
//  SuperHeroesTableViewController.swift
//  Superheroes and Laureates
//
//  Created by rayaan on 13/04/19.
//  Copyright © 2019 Northwest. All rights reserved.
//

import UIKit

class SuperHeroesTableViewController: UITableViewController {

    var powers : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        Superheroes.shared.fetchSuperHero()
        NotificationCenter.default.addObserver(self, selector: #selector(herosRetrieved), name: Notification.Name("Heros Retrieved"), object: nil)
    }
    
    @objc func herosRetrieved(){
        DispatchQueue.main.sync {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SUPERHEROS"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Superheroes.shared.members.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "superheroes", for: indexPath)
        let heros = Superheroes.shared[indexPath.row]
        powers = heros.powers
        var powerData:String = ""
        for i in 0..<powers.count{
            if i == powers.count-1{
                powerData = powerData + "\(powers[i])"
            }else{
            powerData = powerData + "\(powers[i]), "
            }
            
        }
        cell.textLabel?.text = "\(heros.name) (AKA: \(heros.secretIdentity))"
        cell.detailTextLabel?.text = powerData
        return cell
    }
}
