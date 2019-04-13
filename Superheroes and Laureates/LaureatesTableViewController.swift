//
//  SecondViewController.swift
//  Superheroes and Laureates
//
//  Created by rayaan on 13/04/19.
//  Copyright © 2019 Northwest. All rights reserved.
//

import UIKit

class LaureatesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Laureates.shared.fetchLaureates()
        NotificationCenter.default.addObserver(self, selector: #selector(laureatesRetrieved), name: Notification.Name("Laureates Retrieved"), object: nil)
    }
    
    @objc func laureatesRetrieved(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "LAUREATES"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Laureates.shared.numofLas()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "laureates", for: indexPath)
        let laureate = Laureates.shared[indexPath.row]
        cell.textLabel?.text = "\(laureate.firstName) \(laureate.surName)"
        cell.detailTextLabel?.text = "\(laureate.bornDate) \(laureate.diedDate)"
        return cell
    }


    
    
}//end of class view controller

