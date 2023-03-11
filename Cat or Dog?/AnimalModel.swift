//
//  AnimalModel.swift
//  Cat or Dog?
//
//  Created by Sam Grover on 2023-03-10.
//

import Foundation
import SwiftUI

class AnimalModel: ObservableObject{
    //Published: notify everone when it is updated and all observable object can update the UI
    @Published var animal = Animal(imageUrl: "")
    
    func getAnimal(){
        //makes the request to download animal information
       
        let stringUrl = Bool.random() ? catUrl : dogUrl  // will give us ramdomly one of two URL
        
        //create a URL object
        let url = URL(string: stringUrl)
        
        // check URL isn't nil
        guard url != nil else{
            print("LOG: Coudn't print the Url object")
            return
        }
        
        //Get a URL session
        let session = URLSession.shared
        
        //Create a datatask - for making call for us
        let datatask =  session.dataTask(with: url!) { data, responce, error in
            
            // if there is no error and the data is returned then parse the JSON
            if error == nil && data != nil {
                
                //parsing JSON
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: Any]]{
                        
                        let item = json.isEmpty ? [:] : json[0]
                        
                        if let animal = Animal(json: item){
                            DispatchQueue.main.async {
                                while animal.results.isEmpty {}
                                self.animal = animal
                            }
                        }
                    }
                }catch{
                    print("LOG: Couldn't parse the JSON")
                }
            }
        }
        //start the data task
        datatask.resume()
    }
}
