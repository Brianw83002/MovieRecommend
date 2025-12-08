//
//  Movie.swift
//  MovieRecApp
//
//  Created by Beatriz Torres on 12/7/25.
//

import Foundation

enum Genre: String, CaseIterable, Identifiable, Codable {
    case action = "Action"
    case comedy = "Comedy"
    case drama = "Drama"
    case Horror = "Horror"
    case romance = "Romance"
    case scifi = "Sci-Fi"
    
    var id : String { self.rawValue }
}

struct Movie: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let genre: String
    let description: String
    let rating: Double
    let posterImageName: String
    
    static let sampleMovies: [Movie] = [
        Movie(
            title: "Inception",
            genre: Genre.scifi.rawValue,
            description: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
            rating: 8.8,
            posterImageName: "inception"
        ),
        Movie(
            title: "The Dark Knight",
            genre: Genre.action.rawValue,
            description: "When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.",
            rating: 9.0,
            posterImageName: "dark_knight"
        ),
        Movie(
            title: "Forrest Gump",
            genre: Genre.drama.rawValue,
            description: "The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal and other historical events unfold from the perspective of an Alabama man with an IQ of 75.",
            rating: 8.8,
            posterImageName: "forrest_gump"
        ),
        Movie(
            title: "The Hangover",
            genre: Genre.comedy.rawValue,
            description: "Three buddies wake up from a bachelor party in Las Vegas, with no memory of the previous night and the bachelor missing.",
            rating: 7.7,
            posterImageName: "hangover"
        ),
        Movie(
            title: "The Conjuring",
            genre: Genre.Horror.rawValue,
            description: "Paranormal investigators Ed and Lorraine Warren work to help a family terrorized by a dark presence in their farmhouse.",
            rating: 7.5,
            posterImageName: "conjuring"
        ),
        Movie(
            title: "The Notebook",
            genre: Genre.romance.rawValue,
            description: "A poor yet passionate young man falls in love with a rich young woman, giving her a sense of freedom, but they are soon separated because of their social differences.",
            rating: 7.8,
            posterImageName: "notebook"
            )
        ]
}
