//
//  MovieStore.swift
//  MovieRecApp
//
//  Created by Beatriz Torres on 12/7/25.
//

import Foundation
import SwiftUI

@MainActor
class MovieStore: ObservableObject {
    @Published var movies: [Movie] = Movie.sampleMovies
    
    func movies(for genre: Genre) -> [Movie] {
        return movies.filter { $0.genre == genre.rawValue }
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
}
