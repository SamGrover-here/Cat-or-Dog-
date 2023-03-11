//
//  Animal.swift
//  Cat or Dog?
//
//  Created by Sam Grover on 2023-03-10.
//

import Foundation
import CoreML
import Vision

struct Result: Identifiable{
    var id = UUID()
    var imageLabel: String
    var confidence: Double
}


class Animal{
    
    //url of the image - for fetching the image data
    var imageUrl: String
    
    
    //image data - for displaying it in UI
    var imageData: Data?  /// can be optional as we havn't downloaded the data yet
    
    //classified results
    var results: [Result]
    
    let modelFile = try! MobileNetV2(configuration: MLModelConfiguration())
    
    //this animal has no information
    init(imageUrl: String, imageData: Data? = nil) {
        self.imageUrl = ""
        self.imageData = nil
        self.results = []
    }
    
    init?(json: [String: Any]){
        
        // check that the json has URL
        guard let imageUrl = json["url"] as? String else{
            return nil
        }
        
        // Set the animal properties
        self.imageUrl = imageUrl
        self.imageData = nil
        self.results = []
        
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
                self.classifyAnimal()
            }
        }
        
        // start the datatask
        datatask.resume()
    }
    
    func classifyAnimal(){
        // get a reference to the model
        let model = try! VNCoreMLModel(for: modelFile.model)
        
        //create a image handler
        let handler = VNImageRequestHandler(data: imageData!)
        
        // create a request to model
        let request = VNCoreMLRequest(model: model) { request, error in
            
            
            guard let results = request.results as? [VNClassificationObservation] else {
                print("LOG: Couldn't classify animals")
                return
            }
            
            //Update the results
            for classifcation in results{
                
                var identifier = classifcation.identifier
                identifier = identifier.prefix(1).capitalized + identifier.dropFirst()
                self.results.append(Result(imageLabel: identifier, confidence: Double(classifcation.confidence)))
            }
        }
        
        // execute the request
        do{
            try handler.perform([request])
        }catch{
            print("LOG: Invalid Image")
        }
    }
}
