import SwiftUI

struct MovieRecPage: View {
    @EnvironmentObject var movieStore: MovieStore
    let selectedGenres: [Genre]

    @State private var matchingMovies: [Movie] = []
    @State private var currentIndex: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("Your Movie Recommendation")
                .font(.largeTitle)
                .fontWeight(.bold)

            if !matchingMovies.isEmpty {
                VStack(spacing: 20) {

                    
                    if !matchingMovies[currentIndex].posterImageName.isEmpty {
                        Image(matchingMovies[currentIndex].posterImageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 300)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                   
                    
                    NavigationLink(destination: MovieDetailView(movie: matchingMovies[currentIndex])) {
                        Text(matchingMovies[currentIndex].title)
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }

                    
                    Text("\(currentIndex + 1)/\(matchingMovies.count)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            } else {
                Text("No movies found.")
                    .font(.title3)
            }

            HStack(spacing: 40) {
                Button(action: showPrevious) {
                    Text("Previous")
                        .frame(width: 120, height: 45)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                }
                Button(action: showNext) {
                    Text("Next")
                        .frame(width: 120, height: 45)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }

            Spacer()
        }
        .padding()
        .onAppear(perform: loadMovies)
    }

    private func loadMovies() {
        let filtered = movieStore.movies.filter { selectedGenres.contains($0.genre) }
        matchingMovies = filtered
        if !matchingMovies.isEmpty { currentIndex = 0 }
    }

    private func showNext() {
        if !matchingMovies.isEmpty {
            currentIndex = (currentIndex + 1) % matchingMovies.count
        }
    }

    private func showPrevious() {
        if !matchingMovies.isEmpty {
            currentIndex = (currentIndex - 1 + matchingMovies.count) % matchingMovies.count
        }
    }
}
