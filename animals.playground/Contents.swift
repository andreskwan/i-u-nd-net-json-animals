//
//  animals.playground
//  iOS Networking
//
//  Created by Jarrod Parkes on 09/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForAnimalsJSON = NSBundle.mainBundle().pathForResource("animals", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawAnimalsJSON = NSData(contentsOfFile: pathForAnimalsJSON!)

/* Error object */
var parsingAnimalsError: NSError? = nil

/* Parse the data into usable form */
//let parsedAnimalsJSON:AnyObject?

//do {
var parsedAnimalsJSON = try! NSJSONSerialization.JSONObjectWithData(rawAnimalsJSON!, options: .AllowFragments) as! NSDictionary
//} catch {
//    print("Could not parse the data as JSON: '\(rawAnimalsJSON)")
//}


func parseJSONAsDictionary(dictionary: NSDictionary) {
    /* Start playing with JSON here... */
    
    guard let photosDictionary = dictionary[Constants.JSONResponseKeys.Photos] as? [String:AnyObject]
        else {
            //error extracting the photosDictionary from the JSON represented by a NSDictionary
            return
    }
    
    print(photosDictionary)
    
    guard let arrayOfPhotoDictionaries = photosDictionary[Constants.JSONResponseKeys.Photo] as? [[String:AnyObject]]
        else {
            //error extracting array of photos from the photosDictionary
            print("Cannot find key 'photo' in \(photosDictionary)")
            return
    }
    
    //how many photos are in the JSON
    print("how many photos are in the JSON: \(arrayOfPhotoDictionaries.count)")
    print("URL of the image referenced by index 3 \(arrayOfPhotoDictionaries[2]["url_m"])")
    
    var indexValue = 0
    for photo in arrayOfPhotoDictionaries {
        
        guard let content = photo["comment"]!["_content"] as? String
            else {
                //do I need to return in this case? I don't think so!
                return
        }
        if ((content.rangeOfString("interrufftion")) != nil) {
            print("index: \(indexValue)")
            print(content)
        }
        indexValue += 1
    }

}

struct Constants {
    struct JSONResponseKeys {
        static let Photos = "photos"
        static let Photo = "photo"
    }
    
    struct JSONResponseValues {
        static let OKStatus = "ok"
    }
}

parseJSONAsDictionary(parsedAnimalsJSON)
