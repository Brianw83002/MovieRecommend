import SwiftUI

private enum DetailTheme {
    static let bg = Color(red: 0.975, green: 0.975, blue: 0.985)
    static let surface = Color.white
    static let border = Color.black.opacity(0.08)
    static let subtitle = Color.black.opacity(0.60)
}

struct MovieDetailView: View {
    let movie: Movie
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            DetailTheme.bg.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    if !movie.posterImageName.isEmpty {
                        Image(movie.posterImageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 380)
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .shadow(color: Color.black.opacity(0.10), radius: 16, x: 0, y: 10)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text(movie.title)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)

                        Text("\(movie.genre.rawValue) • ⭐︎ \(movie.rating, specifier: "%.1f")")
                            .font(.subheadline)
                            .foregroundColor(DetailTheme.subtitle)

                        Divider().padding(.vertical, 4)

                        Text("Description")
                            .font(.headline)
                            .foregroundColor(.black)

                        Text(movie.description)
                            .font(.body)
                            .foregroundColor(.black)
                            .lineSpacing(4)
                    }
                    .padding(16)
                    .background(card)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .top)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // <-- forces full-screen layout
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { dismiss() } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left").foregroundColor(.black).bold()
                        Text("Return").foregroundColor(.black).bold()
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var card: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(DetailTheme.surface)
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(DetailTheme.border, lineWidth: 1)
            )
    }
}
