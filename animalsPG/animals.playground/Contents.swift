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
var parsedAnimalsJSON = try! NSJSONSerialization.JSONObjectWithData(rawAnimalsJSON!, options: .AllowFragments) as! NSDictionary

func parseJSONAsDictionary(dictionary: NSDictionary) {
    /* Start playing with JSON here... */
    
    guard let photosDictionary = dictionary[Constants.JSONResponseKeys.Photos] as? [String:AnyObject]
        else {
            //error extracting the photosDictionary from the JSON represented by a NSDictionary
            print("Cannot find key 'photos' in \(parsedAnimalsJSON)")
            return
    }
    
    guard let arrayOfPhotoDictionaries = photosDictionary[Constants.JSONResponseKeys.Photo] as? [[String:AnyObject]]
        else {
            //error extracting array of photos from the photosDictionary
            print("Cannot find key 'photo' in \(photosDictionary)")
            return
    }
    
    //how many photos are in the JSON
    print("how many photos are in the JSON: \(arrayOfPhotoDictionaries.count)")
    guard let total = photosDictionary[Constants.JSONResponseKeys.TotalPhotos] as? Int else {
        print("Cannot find key 'total' in \(photosDictionary)")
        return
    }
    
    print("total number of fotos: \(total)")
    
    for (index, photo) in arrayOfPhotoDictionaries.enumerate() {
        guard let commentDictionary = photo[Constants.JSONResponseKeys.Comment] as? [String:AnyObject] else {
            //do I need to return in this case? I don't think so!
            return
        }
        guard let content = commentDictionary[Constants.JSONResponseKeys.Content] as? String else {
            return
        }
        if ((content.rangeOfString("interrufftion")) != nil) {
            print("index: \(index)")
            print(content)
        }
        if let photoURL = photo[Constants.JSONResponseKeys.URLMedia] as? String where index == 2 {
            print(photoURL)
        }
    }
}

struct Constants {
    struct JSONResponseKeys {
        static let Photos = "photos"
        static let Photo = "photo"
        static let TotalPhotos = "total"
        static let Comment = "comment"
        static let Content = "_content"
        static let URLMedia = "url_m"
    }
    
    struct JSONResponseValues {
        static let OKStatus = "ok"
    }
}

parseJSONAsDictionary(parsedAnimalsJSON)
