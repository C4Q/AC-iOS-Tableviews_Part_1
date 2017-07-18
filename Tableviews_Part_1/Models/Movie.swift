//
//  Movie.swift
//  Tableviews_Part_1
//
//  Created by Louis Tur on 9/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class Movie {
	
	var title: String
	var year: Int
	var genre: String
	//     var cast: [Actor]
	var cast: [String]
	var locations: [String]
	var summary: String
	
	init(title: String, year: Int, genre: String, cast: [String], locations: [String], summary: String) {
		self.title = title
		self.year = year
		self.genre = genre
		self.cast = cast
		self.locations = locations
		self.summary = summary
	}
	
	//    init(from data: [String : Any]) {
	//        // 1. Start by getting our property values and casting them..
	//        //    hint: use if let statements to check for values and cast them
	//
	//        if let movieTitle: String = data["name"] as? String,
	//            let movieYear: Int = data["year"] as? Int,
	//            let movieGenre: String = data["genre"] as? String,
	//            let movieLocations: [String] = data["locations"] as? [String],
	//            let movieSynopsis: String = data["description"] as? String {
	//
	//            self.title = movieTitle
	//            self.year = movieYear
	//            self.genre = movieGenre
	//            self.locations = movieLocations
	//            self.summary = movieSynopsis
	//
	//            //  2. And what about the actors?
	//            if let allActorNames: [String] = data["cast"] as? [String] {
	//                var castContainer: [Actor] = []
	//
	//                for actorName in allActorNames {
	//                    // 3. Time to update the Actor initializer now
	//                    castContainer.append(Actor(from: actorName))
	//                }
	//
	//                self.cast = castContainer
	//            }
	//            else {
	//                self.cast = [] // all stored properties need a value when initializing
	//            }
	//        }
	//        else {
	//            // How do we silence the error "Return from Initializaer without initializing all stored properties?
	//            self = Movie()
	//        }
	//    }
	//
	init() {
		self.title = ""
		self.year = 1970
		self.genre = ""
		self.cast = []
		self.locations = []
		self.summary = ""
	}
}
