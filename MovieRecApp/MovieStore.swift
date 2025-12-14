import Foundation
import SwiftUI

@MainActor
class MovieStore: ObservableObject {
    @Published var movies: [Movie] = []

    init() {
        loadMovies()
    }

    func movies(for genre: Genre) -> [Movie] {
        return movies.filter { $0.genre == genre }
    }
    
    func randomMovie(for genre: Genre?) -> Movie? {
        let pool: [Movie]
        if let genre = genre {
            pool = movies(for: genre)
        } else {
            pool = movies
        }
        return pool.randomElement()
    }

    private func loadMovies() {
        guard let url = Bundle.main.url(forResource: "movieList", withExtension: "json") else {
            print("movieList.json not found in main bundle!")
            movies = Movie.sampleMovies
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Movie].self, from: data)
            movies = decoded
            print("Loaded \(movies.count) movies from movieList.json")
        } catch {
            print("Failed to load or decode movieList.json:", error)
            movies = Movie.sampleMovies
        }
    }
    
}
