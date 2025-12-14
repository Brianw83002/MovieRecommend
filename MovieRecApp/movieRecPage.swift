import SwiftUI

private enum RecTheme {
    static let bg = Color(red: 0.975, green: 0.975, blue: 0.985)
    static let surface = Color.white
    static let border = Color.black.opacity(0.08)
    static let accent = Color(red: 0.36, green: 0.56, blue: 0.98)
    static let subtitle = Color.black.opacity(0.60)
}

struct MovieRecPage: View {
    @EnvironmentObject var movieStore: MovieStore
    @Environment(\.dismiss) private var dismiss

    let selectedGenres: [Genre]

    @State private var matchingMovies: [Movie] = []
    @State private var currentIndex: Int = 0

    var body: some View {
        ZStack {
            RecTheme.bg.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    header

                    if matchingMovies.isEmpty {
                        emptyState
                    } else {
                        movieCard(movie: matchingMovies[currentIndex])
                        controls
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .top)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // <-- forces full-screen layout
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { dismiss() } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                        Text("Recommendation")
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                }
                .buttonStyle(.plain)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .tint(RecTheme.accent)
        .onAppear(perform: loadMovies)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Your Movie Recommendation")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.black)

            Text(matchingMovies.isEmpty ? "No matches yet." : "\(currentIndex + 1) of \(matchingMovies.count)")
                .font(.subheadline)
                .foregroundColor(RecTheme.subtitle)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var emptyState: some View {
        VStack(spacing: 10) {
            Text("No movies found.")
                .font(.headline)
                .foregroundColor(.black)

            Text("Try selecting different genres.")
                .font(.subheadline)
                .foregroundColor(RecTheme.subtitle)

            Button("Edit Genres") { dismiss() }
                .buttonStyle(.borderedProminent)
                .tint(RecTheme.accent)
                .padding(.top, 8)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(card)
    }

    private func movieCard(movie: Movie) -> some View {
        VStack(spacing: 14) {
            if !movie.posterImageName.isEmpty {
                Image(movie.posterImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 320)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }

            NavigationLink(destination: MovieDetailView(movie: movie)) {
                HStack(spacing: 10) {
                    Text(movie.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.subheadline)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(RecTheme.accent)
        }
        .padding(14)
        .background(card)
    }

    private var controls: some View {
        HStack(spacing: 12) {
            Button(action: showPrevious) {
                HStack(spacing: 8) {
                    Image(systemName: "chevron.left").foregroundColor(.black)
                    Text("Previous").foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
            }
            .buttonStyle(.bordered)
            .disabled(matchingMovies.count <= 1)

            Button(action: showNext) {
                HStack(spacing: 8) {
                    Text("Next")
                    Image(systemName: "chevron.right")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .tint(RecTheme.accent)
            .disabled(matchingMovies.count <= 1)
        }
        .padding(.top, 4)
    }

    private var card: some View {
        RoundedRectangle(cornerRadius: 18, style: .continuous)
            .fill(RecTheme.surface)
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(RecTheme.border, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.06), radius: 14, x: 0, y: 8)
    }

    private func loadMovies() {
        matchingMovies = movieStore.movies.filter { selectedGenres.contains($0.genre) }
        currentIndex = 0
    }

    private func showNext() {
        guard !matchingMovies.isEmpty else { return }
        currentIndex = min(currentIndex + 1, matchingMovies.count - 1)
    }

    private func showPrevious() {
        guard !matchingMovies.isEmpty else { return }
        currentIndex = max(currentIndex - 1, 0)
    }
}
