import SwiftUI

struct MovieRecPage: View {

    let selectedGenres: [Genre]

    @State private var matchingMovies: [String] = []
    @State private var currentIndex: Int = 0

    var body: some View {
        VStack(spacing: 30) {

            Text("Your Movie Recommendation")
                .font(.largeTitle)
                .fontWeight(.bold)

            if !matchingMovies.isEmpty {
                Text(matchingMovies[currentIndex])
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
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
        .onAppear {
            loadMovies()
        }
    }

    // MARK: Load & Filter Movies Based on New Format
    func loadMovies() {
        let selectedGenres = self.selectedGenres.map { $0.rawValue }
        
        guard let fileURL = Bundle.main.url(forResource: "movieList", withExtension: "txt"),
              let fileContents = try? String(contentsOf: fileURL) else {
            matchingMovies = ["Error loading movieList.txt"]
            return
        }

        let lines = fileContents.split(separator: "\n").map(String.init)

        var tempMovies: [String] = []

        for line in lines {
            let parts = line.split(separator: ":")
            if parts.count != 2 { continue }

            let movie = parts[0].trimmingCharacters(in: .whitespaces)
            let categoriesString = parts[1]
            let categories = categoriesString
                .split(separator: ",")
                .map { $0.trimmingCharacters(in: .whitespaces) }

            // Check for overlap between selected genres and movie categories
            let matches = categories.contains(where: { selectedGenres.contains($0) })

            if matches {
                tempMovies.append(movie)
            }
        }

        matchingMovies = tempMovies

        if !matchingMovies.isEmpty {
            currentIndex = 0
        }
    }

    // MARK: Navigation Buttons
    func showNext() {
        if !matchingMovies.isEmpty {
            currentIndex = (currentIndex + 1) % matchingMovies.count
        }
    }

    func showPrevious() {
        if !matchingMovies.isEmpty {
            currentIndex = (currentIndex - 1 + matchingMovies.count) % matchingMovies.count
        }
    }
}

#Preview {
    MovieRecPage(selectedGenres: [.action, .comedy])
}
