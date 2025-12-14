//
//  Movie.swift
//  MovieRecApp
//

import Foundation

enum Genre: String, CaseIterable, Identifiable, Codable {
    case action = "Action"
    case adventure = "Adventure"
    case animation = "Animation"
    case biography = "Biography"
    case comedy = "Comedy"
    case crime = "Crime"
    case drama = "Drama"
    case family = "Family"
    case fantasy = "Fantasy"
    case horror = "Horror"
    case music = "Music"
    case musical = "Musical"
    case mystery = "Mystery"
    case romance = "Romance"
    case scifi = "Sci-Fi"
    case thriller = "Thriller"
    case war = "War"

    var id: String { rawValue }
}

struct Movie: Identifiable, Hashable, Codable {
    var id: String { title }
    let title: String
    let genre: Genre
    let description: String
    let rating: Double
    let posterImageName: String

    init(title: String, genre: Genre, description: String, rating: Double, posterImageName: String) {
        self.title = title
        self.genre = genre
        self.description = description
        self.rating = rating
        self.posterImageName = posterImageName
    }

    static let sampleMovies: [Movie] = [
        Movie(
            title: "Inception",
            genre: .scifi,
            description: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
            rating: 8.8,
            posterImageName: "inception"
        ),
        Movie(
            title: "The Dark Knight",
            genre: .action,
            description: "When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.",
            rating: 9.0,
            posterImageName: "dark_knight"
        )
        // Add more sample movies if needed
    ]
}
