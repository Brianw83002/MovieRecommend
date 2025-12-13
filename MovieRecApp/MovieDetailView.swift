import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            
            VStack(alignment: .center, spacing: 16) {
                
                if !movie.posterImageName.isEmpty {
                    Image(movie.posterImageName)
                        .resizable()
                        .scaledToFit()
                        
                        .frame(maxHeight: 400)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }

                
                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.largeTitle)
                        .bold()

                    Text("\(movie.genre.rawValue) • ⭐️ \(movie.rating, specifier: "%.1f")")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    Divider()

                    Text("Description")
                        .font(.title2)
                        .bold()

                    Text(movie.description)
                        .font(.body)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
        .navigationTitle(movie.title)
        
        
        #if os(iOS)
        
        .navigationBarTitleDisplayMode(.inline)
        #endif
        
    }
}
