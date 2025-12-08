//
//  MovieRecAppApp.swift
//  MovieRecApp
//
//  Created by csuftitan on 11/24/25.
//

import SwiftUI

@main
struct MovieRecAppApp: App {
    @StateObject private var movieStore = MovieStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(movieStore)
        }
}
