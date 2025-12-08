import SwiftUI

struct GenreSelect: View {
    @EnvironmentObject var movieStore: MovieStore

    @State private var selectedGenres: Set<String> = []
    @State private var showAlert = false

    @State private var goToMoviePage = false

//    let genres = [
//        "Action", "Comedy", "Drama", "Horror", "Sci-Fi",
//        "Romance", "Thriller", "Fantasy", "Animation",
//        "Documentary", "Mystery", "Adventure", "Family", "Crime"
//    ]
    
    let genres = Genre.allCases.map { $0.rawValue }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {

                HStack {
                    Text("Select a Genre")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Spacer()

                    Button(action: handleContinue) {
                        Text("Continue")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(genres, id: \.self) { genre in
                            GenreButton(
                                title: genre,
                                isSelected: selectedGenres.contains(genre),
                                action: { toggleSelection(for: genre) }
                            )
                        }
                    }
                    .padding(.vertical)
                }

                Spacer()

                // Navigation Trigger
                NavigationLink(
                    destination: MovieRecPage(selectedGenres: Array(selectedGenres)),
                    isActive: $goToMoviePage
                ) { EmptyView() }
            }
            .padding()
            .alert("Please select any of the following", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }

    func toggleSelection(for genre: String) {
        if selectedGenres.contains(genre) {
            selectedGenres.remove(genre)
        } else {
            selectedGenres.insert(genre)
        }
    }

    func handleContinue() {
        if selectedGenres.isEmpty {
            showAlert = true
        } else {
            goToMoviePage = true
        }
    }
}

struct GenreButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(isSelected ? .blue : .gray)
                    .font(.title2)

                Text(title)
                    .font(.title3)
                    .foregroundColor(.primary)

                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}
