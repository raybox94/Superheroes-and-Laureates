//
//  Laureates.swift
//  Superheroes and Laureates
//
//  Created by rayaan on 13/04/19.
//  Copyright © 2019 Northwest. All rights reserved.
//

import Foundation
class Laureates{
    
    struct LaureatesModel {
        var firstName:String
        var surName:String
        var bornDate:String
        var diedDate:String
    }
    
    private init(){}
    
    static let shared = Laureates()
    static var finalLaureatesDetails:[LaureatesModel] = []
    //    var dummy:[LaureatesModel]?
    func fetchLaureates() -> Void {
        guard let url = Bundle.main.url(forResource: "laureates", withExtension: "json")
            else{
                print("No File Exist")
                return
        }
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url, completionHandler: displaylaureates).resume()
    } //end of function fetchlaureates
    
    
    
        func displaylaureates(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        var laureates:[[String:Any]]!
        do {
            try laureates = JSONSerialization.jsonObject(with: data!, options: .allowFragments)  as?  [[String:Any]]
            if laureates != nil {
                for i in 0..<laureates.count{
                    let laureatesArray = laureates[i]
                    let firstName = laureatesArray["firstname"] as? String
                    let surName = laureatesArray["surname"] as? String
                    let bornDate = (laureatesArray["born"] as? String)!
                    let diedDate = (laureatesArray["died"] as? String)!
                    Laureates.finalLaureatesDetails.append(LaureatesModel.init(firstName: firstName ?? "", surName: surName ?? "", bornDate: bornDate, diedDate: diedDate))
                }
                NotificationCenter.default.post(name: Notification.Name("Laureates Retrieved"), object: nil)
            }
            
        } catch {
            print(error)
        }
    }//end of function display Laureates
    
    
    func laureats(index:Int) -> LaureatesModel{
        return Laureates.finalLaureatesDetails[index]
    }
    subscript(index:Int) -> LaureatesModel{
        return Laureates.finalLaureatesDetails[index]
    }
    func numofLas() -> Int{
        return Laureates.finalLaureatesDetails.count
    }
}
