//
//  Superheroes.swift
//  Superheroes and Laureates
//
//  Created by rayaan on 13/04/19.
//  Copyright © 2019 Northwest. All rights reserved.
//

import Foundation
class Superheroes{
    
    static let shared = Superheroes()
    var members:[Members] = []
    func fetchSuperHero() -> Void {
        guard let url = Bundle.main.url(forResource: "squad", withExtension: "json")
            else{
                print("No File")
                return
        }
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url, completionHandler: superheroDetails).resume()
    }//end of function fetchSuperHero
    
    
    
    func superheroDetails(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        do {
            let decoder = JSONDecoder()
            let superhero = try decoder.decode(Superhero.self, from: data!)
            members = superhero.members
            NotificationCenter.default.post(name: Notification.Name("Heros Retrieved"), object: nil)
        }
            
        catch {
            print(error)
        }
    }
    func heros(index:Int) -> Members{
        return members[index]
    }
    subscript(index:Int) -> Members{
        return members[index]
    }
    func numofLas() -> Int{
        return members.count
    }
}//end of class SuperHeroes

class Superhero: Codable {
    var members:[Members]
}//end of class Superhero

class Members: Codable{
    var name:String
    var secretIdentity:String
    var powers:[String]
}//end of class Members
