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
    }
    // 1 
    print(achievementsWithPointValueGreaterThan10)
    // 2.1 average
    print(Double(sumOfPointValue)/Double(achievementsWithPoints))
}

parseJSONAsDictionary(parsedAchievementsJSON)
