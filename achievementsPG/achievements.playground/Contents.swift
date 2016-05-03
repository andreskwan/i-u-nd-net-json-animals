//
//  achievements.playground
//  iOS Networking
//
//  Created by Jarrod Parkes on 09/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForAchievementsJSON = NSBundle.mainBundle().pathForResource("achievements", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawAchievementsJSON = NSData(contentsOfFile: pathForAchievementsJSON!)

/* Error object */
var parsingAchivementsError: NSError? = nil

/* Parse the data into usable form */
var parsedAchievementsJSON = try! NSJSONSerialization.JSONObjectWithData(rawAchievementsJSON!, options: .AllowFragments) as! NSDictionary

func parseJSONAsDictionary(dictionary: NSDictionary) {
    /* Start playing with JSON here... */
    // 1 achievements have a point value greater than 10
    guard let achievements = parsedAchievementsJSON["achievements"] as? [[String:AnyObject]] else {
        print("can't find achievements in \(parsedAchievementsJSON)")
        return
    }
    
    // 1
    var achievementsWithPointValueGreaterThan10 = 0
    // 2
    var sumOfPointValue = 0
    var achievementsWithPoints = 0
    
    // 4 --------------------------------------------
    var categoriesIdArray = [Int]()
    //key is the categoryID and Int is the number of achivements whit this id
    var categoryCount = [Int:Int]()
    
    guard let categoriesArrayOfDictionaries = parsedAchievementsJSON["categories"] as? [[String:AnyObject]] else {
        print("Can't find categories in ")
        return
    }
    
    for categoryDictionary in categoriesArrayOfDictionaries {
        
        if let title = categoryDictionary["title"] as? String where title == "Matchmaking" {
            print(title)
            guard let children = categoryDictionary["children"] as? [[String:AnyObject]] else {
                print("Can't find any children")
                return
            }
            for child in children {
                guard let categoryID = child["categoryId"] as? Int else {
                    print("Can't find any categoryId")
                    return
                }
                categoriesIdArray.append(categoryID)
            }
        } else {
            print("nothing found")
        }
    }
    // initialize dictionary
    for categoryID in categoriesIdArray {
        categoryCount[categoryID] = 0
    }
    
    for achievement in achievements {
        guard let points = achievement["points"] as? Int else {
            return
        }
        // 1
        if points > 10 {
            achievementsWithPointValueGreaterThan10 += 1
        }
        // 2.0
        sumOfPointValue += points
        achievementsWithPoints += 1
        
        // 3 what mission for achievement "Cool Running"
        if let title = achievement["title"] as? String where title == "Cool Running" {
            guard let description = achievement["description"] as? String else {
                return
            }
            print(description)
        }
        // 4
        guard let categoryID = achievement["categoryId"] as? Int else {
            return
        }
        if categoriesIdArray.contains(categoryID) {
            categoryCount[categoryID] = categoryCount[categoryID]! + 1
        }
    
    }
    // 1 
    print(achievementsWithPointValueGreaterThan10)
    // 2.1 average
    print(Double(sumOfPointValue)/Double(achievementsWithPoints))
    // 4 
    print(categoryCount)
}

parseJSONAsDictionary(parsedAchievementsJSON)
