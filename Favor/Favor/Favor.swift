//
//  Favor.swift
//  Favor
//
//  Created by Gonimah, Mayada on 4/14/16.
//  Copyright © 2016 Gonimah, Mayada. All rights reserved.
//
import Foundation
import Firebase

struct Favor {
    let key: String!
    let name: String!
    let addedByUser: String!
    let ref: Firebase?
    var completed: Bool!
    let deadline : String!
    
    init(name: String, addedByUser: String, completed: Bool, key: String = "", deadline: String) {
        self.key = key
        self.name = name
        self.addedByUser = addedByUser
        self.completed = completed
        self.deadline = deadline
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot) {
        key = snapshot.key
        name = snapshot.value["name"] as! String
        addedByUser = snapshot.value["addedByUser"] as! String
        completed = snapshot.value["completed"] as! Bool
        deadline = snapshot.value["deadline"] as? String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "name": name,
            "addedByUser": addedByUser,
            "completed": completed,
            "deadline" : deadline
        ]
    }
}
