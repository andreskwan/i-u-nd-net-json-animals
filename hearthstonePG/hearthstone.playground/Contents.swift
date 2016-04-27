//
//  hearthstone.playground
//  iOS Networking
//
//  Created by Jarrod Parkes on 09/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForHearthstoneJSON = NSBundle.mainBundle().pathForResource("hearthstone", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawHearthstoneJSON = NSData(contentsOfFile: pathForHearthstoneJSON!)

/* Error object */
var parsingHearthstoneError: NSError? = nil

/* Parse the data into usable form */
var parsedHearthstoneJSON = try! NSJSONSerialization.JSONObjectWithData(rawHearthstoneJSON!, options: .AllowFragments) as! NSDictionary

func parseJSONAsDictionary(dictionary: NSDictionary) {
    /* Start playing with JSON here... */
    guard let arrayOfGameElements = parsedHearthstoneJSON[Constants.JSONKeys.Basic] as? [[String:AnyObject]] else {
        print("can't find value for key: \(Constants.JSONKeys.Basic) on JSON: \(parsedHearthstoneJSON)")
        return
    }
    
    print(arrayOfGameElements.count)
    var minionsAtFiveDollars = 0
    var minionsWithBattleCry = 0
    var minionCostArray = [Int]()
    for (index, gameElementDictionary) in arrayOfGameElements.enumerate() {
        guard let type = gameElementDictionary["type"] as? String else {
            print("can't find type")
            return
        }
        
        if type == "Minion" {
            guard let minionCost = gameElementDictionary["cost"] as? Int else {
                print("can't find minion cost")
                return
            }
            if minionCost >= 5 {
                minionsAtFiveDollars = minionsAtFiveDollars + 1
                print("index: \(index), cost: \(minionCost)")
            }
            
            print(index)
            print(minionCost)
            guard let text = gameElementDictionary["text"] as? String else {
                print("can't find values for \"text\" key")
                return
            }
            if text.rangeOfString("Battlecry") != nil {
                minionsWithBattleCry = minionsWithBattleCry + 1
                print(text)
            }
        }
        if type == "Weapon" {
            guard let durability = gameElementDictionary["durability"] as? Int else {
                print("can't find durabily of the element")
                return
            }
            if durability == 2 {
               print("index: \(index), durability: \(durability)")
            }
        }
    }
    print(minionsWithBattleCry)
    print(minionsAtFiveDollars)
}

struct Constants {
    struct JSONKeys {
        static let Basic = "Basic"
        
    }
}
parseJSONAsDictionary(parsedHearthstoneJSON)
