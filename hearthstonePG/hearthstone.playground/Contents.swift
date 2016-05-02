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

/* Parse the data Floato usable form */
var parsedHearthstoneJSON = try! NSJSONSerialization.JSONObjectWithData(rawHearthstoneJSON!, options: .AllowFragments) as! NSDictionary

func parseJSONAsDictionary(dictionary: NSDictionary) {
    /* Start playing with JSON here... */
    guard let arrayOfGameElements = parsedHearthstoneJSON[Constants.JSONKeys.Basic] as? [[String:AnyObject]] else {
        print("can't find value for key: \(Constants.JSONKeys.Basic) on JSON: \(parsedHearthstoneJSON)")
        return
    }
    
    print(arrayOfGameElements.count)
    // 1
    var minionsAtFiveDollars = Float(0)
    // 3
    var minionsWithBattleCry = 0
    
    var totalMiniosCost = Float(0)
    var totalNumberOfMinions = Float(0)

    var totalCostWithoutCeroCostMinions = Float(0)
    var totalAttack = Float(0)
    var totalHealt = Float(0)
    
    for (index, gameElementDictionary) in arrayOfGameElements.enumerate() {
        guard let type = gameElementDictionary["type"] as? String else {
            print("can't find type")
            return
        }
        
        if type == "Minion" {
            // 1 - How many minions have a cost of 5?
            guard let minionCost = gameElementDictionary["cost"] as? Float else {
                print("can't find minion cost")
                return
            }
            if minionCost == 5 {
                minionsAtFiveDollars = minionsAtFiveDollars + 1
                print("index: \(index), cost: \(minionCost)")
            }
            // 3 - How many minons have a "Battlecry" effect
            if let text = gameElementDictionary["text"] as? String {
                if text.rangeOfString("Battlecry") != nil {
                    minionsWithBattleCry = minionsWithBattleCry + 1
                    print("index: \(index)")
                    print("text: \(text)")
                    
                }
            }
            // 4 - average cost of common minions
            guard let attack = gameElementDictionary["attack"] as? Float else {
                print("can't find attack for minion at index: \(index)")
                break
            }
            guard let health = gameElementDictionary["health"] as? Float else {
                print("can't find health for minion at index: \(index)")
                break
            }
            // problem 
            guard let rarity = gameElementDictionary["Common"] as? String else {
                print("can't find rarity common for minion at index: \(index)")
                break
            }
            if rarity == "common" {
                totalMiniosCost = totalMiniosCost + minionCost
                totalNumberOfMinions = totalNumberOfMinions + 1
                print("index: \(index)")
            }
            print(index)
            print(minionCost)
            // 5 - what is the average stats-to-cost-ratio = (attack + health)/cost
            if minionCost > 0.0 {
                totalCostWithoutCeroCostMinions = totalCostWithoutCeroCostMinions + minionCost
                totalAttack = totalAttack + attack
                totalHealt = totalHealt + health
            }
        }
        // 2 - How many weapons have a durability of 2?
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
//    print(minionsAtFiveDollars)
//    print("average cost = \(totalMiniosCost)/\(totalNumberOfMinions) = \(totalMiniosCost/totalNumberOfMinions) ")
//    print("stats-to-cost-ratio = (\(totalAttack)+\(totalHealt))/\(totalNumberOfMinions) = \( (totalAttack + totalHealt)/totalNumberOfMinions) ")
}

struct Constants {
    struct JSONKeys {
        static let Basic = "Basic"
        
    }
}
parseJSONAsDictionary(parsedHearthstoneJSON)
