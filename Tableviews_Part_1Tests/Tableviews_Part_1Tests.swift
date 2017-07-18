//
//  Tableviews_Part_1Tests.swift
//  Tableviews_Part_1Tests
//
//  Created by Louis Tur on 9/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import XCTest
@testable import Tableviews_Part_1

class Tableviews_Part_1Tests: XCTestCase {
    
    var hungerGames: Movie!
    let validTestData: [[String : Any]] = [
        [
            "name": "The Hunger Games",
            "year": 2012,
            "genre": "drama",
            "cast": ["Jennifer Lawrence", "Josh Hutcherson", "Liam Hemsworth"],
            "locations": ["New York", "Wisconsin"],
            "description": "Katniss Everdeen voluntarily takes her younger sister\'s place in the Hunger Games"
        ],
        [
            "name": "American Sniper",
            "year": 2014,
            "genre": "drama",
            "cast": ["Bradley Cooper", "Sienna Miller", "Kyle Gallner"],
            "locations": ["Los Angeles", "Detroit", "Morocco"],
            "description": "Navy S.E.A.L. sniper Chris Kyle\'s pinpoint accuracy saves countless lives"
        ]
    ]
    
    let invalidTestData: [String : Any] = [
        "name": "American Sniper",
        "year": 2014,
        "genre": "drama",
        "cast": ["Bradley Cooper", "Sienna Miller", "Kyle Gallner"],
        "director": "Clint Eastwood", // incorrect key/value pair!
        "description": "Navy S.E.A.L. sniper Chris Kyle\'s pinpoint accuracy saves countless lives"
    ]

    let allMovieData = movies
    internal var singleMovieMinions: Movie!
    internal var singleMovieMinionsActorArray: [Actor]!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
//        self.hungerGames = Movie()
//        self.hungerGames.title = "The Hunger Games"
//        self.hungerGames.year = 2012
//        self.hungerGames.genre = "drama"
//        self.hungerGames.cast = [Actor(from: "Jennifer Lawrence"), Actor(from: "Josh Hutcherson"), Actor(from: "Liam Hemsworth")]
//        self.hungerGames.locations = ["New York", "Wisconsin"]
//        self.hungerGames.summary = "Katniss Everdeen voluntarily takes her younger sister\'s place in the Hunger Games"
//
//        self.singleMovieMinions = Movie(from: allMovieData[0])
//        self.singleMovieMinionsActorArray = [
//            Actor(from: "Sandra Bullock"),
//            Actor(from: "Jon Hamm"),
//            Actor(from: "Michael Keaton")
//        ]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func test_Default_Movie_Init() {
		let testMovie = Movie()

		XCTAssertTrue(testMovie.title == "", "A default init of movie should have an empty sting for title")
		XCTAssertTrue(testMovie.genre == "", "A default init of movie should have an empty sting for genre")
		XCTAssertTrue(testMovie.year == 1970, "A default init of movie should have a year of 1970")
		XCTAssertTrue(testMovie.locations == [], "A default init of movie should have an empty string array for locations")
		XCTAssertTrue(testMovie.cast == [], "A default init of movie should have an empty string array for actors")
		XCTAssertTrue(testMovie.summary == "", "A default init of movie should have an empty sting for summary")
	}
	
//	func test_Full_Movie_Init() {
//		let testMovie = Movie(title: "Rogue One",
//		                      year: 2016,
//		                      genre: "Sci-Fi",
//		                      cast: ["Felicity Jones", "Diego Luna", "Donnie Yen", "Forest Whitaker"],
//		                      locations: ["Far-away Galaxy"],
//		                      summary: "All looks lost for the Rebellion against the Empire as they learn of the existence of a new super weapon, the Death Star. Once a possible weakness in its construction is uncovered, the Rebel Alliance must set out on a desperate mission to steal the plans for the Death Star. The future of the entire galaxy now rests upon its success")
//
//		XCTAssertTrue(testMovie.title == "Rogue One")
//		XCTAssertTrue(testMovie.genre == "Sci-Fi")
//		XCTAssertTrue(testMovie.year == 2016)
//		XCTAssertTrue(testMovie.locations == ["Far-away Galaxy"])
//		XCTAssertTrue(testMovie.cast == ["Felicity Jones", "Diego Luna", "Donnie Yen", "Forest Whitaker"])
//		XCTAssertTrue(testMovie.summary == "All looks lost for the Rebellion against the Empire as they learn of the existence of a new super weapon, the Death Star. Once a possible weakness in its construction is uncovered, the Rebel Alliance must set out on a desperate mission to steal the plans for the Death Star. The future of the entire galaxy now rests upon its success")
//	}
//    func test_Movie_Parsing_From_Valid_Data() {
//        var movies: [Movie] = []
//        for validMovieData in validTestData {
//            let newMovie: Movie = Movie(from: validMovieData)
//            movies.append(newMovie)
//
//            XCTAssertFalse(newMovie.title.isEmpty, "Valid movie data should create a valid movie with a non-empty title string")
//        }
//
//        XCTAssertTrue(movies.count == 2, "There should be two valid movies. Actual: \(movies.count)")
//    }
//
//
//    func test_Movie_Parsing_From_Invalid_Data() {
//        let newMovie: Movie = Movie(from: invalidTestData)
//
//        XCTAssertTrue(newMovie.title == "", "Invalid movie data should create a movie with an empty title string")
//    }
//
//
//    // --- testing membership with closures: filter ---
//    func test_Hunger_Games_When_Parsed_By_Movie_Class() {
//        var allMovies: [Movie] = []
//        for movieData in allMovieData {
//            allMovies.append(Movie(from: movieData))
//        }
//        XCTAssertTrue(allMovies.count == 9, "There should be nine movies in our test database. Actual: \(allMovies.count)")
//
//        let hungerGamesFiltered: [Movie] = allMovies.filter {
//            if $0.title == self.hungerGames.title {
//                return true
//            }
//            return false
//        }
//
//        if let validMovie: Movie = hungerGamesFiltered.first {
//            XCTAssertTrue(validMovie.title == self.hungerGames.title, "Hunger games should have been found during a filter of the movies array")
//        }
//        else {
//            XCTFail("Hunger games does not exist in movie array")
//        }
//    }
//
//
//    // --- testing membership with closures: contains ---
//    func testAllMovieDataIsParsedAndContainsHungerGames() {
//
//        var allMovies: [Movie] = []
//        for movieData in allMovieData {
//            allMovies.append(Movie(from: movieData))
//        }
//        XCTAssertTrue(allMovies.count == 9, "There should be nine movies in our test database. Actual: \(allMovies.count)")
//
//        let moviesContainsMinionsMovie: Bool = allMovies.contains{
//            if $0.title == self.singleMovieMinions.title {
//                return true
//            }
//            return false
//        }
//        XCTAssertTrue(moviesContainsMinionsMovie, "Movie database should contain the Minions movie")
//
//    }
	
}
