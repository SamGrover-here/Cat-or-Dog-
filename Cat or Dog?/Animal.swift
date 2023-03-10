//
//  Animal.swift
//  Cat or Dog?
//
//  Created by Sam Grover on 2023-03-10.
//

import Foundation

class Animal{
    
    //url of the image - for fetching the image data
    var imageUrl: String
    
    
    //image data - for displaying it in UI
    var imageData: Data?  /// can be optional as we havn't downloaded the data yet
    
    //this animal has no information
    init(imageUrl: String, imageData: Data? = nil) {
        self.imageUrl = ""
        self.imageData = nil
    }
    
    init?(json: [String: Any]){
        
        // check that the json has URL
        guard let imageUrl = json["url"] as? String else{
            return nil
        }
        
        // Set the animal properties
        self.imageUrl = imageUrl
        self.imageData = nil
        
        //download the image data
        getImage()
    }
    
    func getImage(){
        
        //create a URL object
        let url = URL(string: imageUrl)
        
        //Check Url is not nil
        guard url != nil else{
            print("LOG: Couldn't find the Image URL")
            return
        }
        
        //Get a url session
        let session = URLSession.shared
        
        // create a data task
        let datatask = session.dataTask(with: url!) { data, responce, error in
            
            // check that there are no errors and there was data
            if error == nil && data != nil{
                self.imageData = data
            }
        }
        
        // start the datatask
        datatask.resume()
    }
}
