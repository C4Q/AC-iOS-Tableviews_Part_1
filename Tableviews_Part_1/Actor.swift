//
//  Actor.swift
//  Tableviews_Part_1
//
//  Created by Louis Tur on 9/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal struct Actor {
    
    internal var firstName: String = ""
    internal var lastName: String = ""
    
    init(from data: String) {
        // 1. Actors will be a little easier to parse
        
        let nameComponents: [String] = data.components(separatedBy: " ")
        
//        if let firstName: String = nameComponents.first,
//            let lastName: String = nameComponents.last {
//            self.firstName = firstName
//            self.lastName = lastName
//        }
        
        // 2. And this works just find, but how about using guard instead
        
        guard let firstName: String = nameComponents.first,
            let lastName:String = nameComponents.last else {
            return
        }
        
        self.firstName = firstName
        self.lastName = lastName
    }
}
