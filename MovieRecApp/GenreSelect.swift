import SwiftUI

private enum Theme {
    static let bg = Color(red: 0.975, green: 0.975, blue: 0.985)
    static let surface = Color.white
    static let border = Color.black.opacity(0.08)
    static let accent = Color(red: 0.36, green: 0.56, blue: 0.98)
    static let chip = Color.white
    static let chipSelected = Color(red: 0.92, green: 0.96, blue: 1.00)
    static let selectedText = Color(red: 0.26, green: 0.50, blue: 0.92)
    static let subtitle = Color.black.opacity(0.58)
}

struct GenreSelect: View {
    @EnvironmentObject var movieStore: MovieStore
    @Environment(\.dismiss) private var dismiss

    @State private var selectedGenres: Set<Genre> = []
    @State private var showAlert = false
    @State private var goToMoviePage = false

    private let genres = Genre.allCases
    private let columns = [
        GridItem(.adaptive(minimum: 170), spacing: 12)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                header

                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(genres) { genre in
                        GenreRowChip(
                            title: genre.rawValue,
                            isSelected: selectedGenres.contains(genre),
                            accent: Theme.accent
                        ) {
                            toggleSelection(for: genre)
                        }
                    }
                }

                Spacer(minLength: 84)
            }
            .padding()
        }
        .background(Theme.bg.ignoresSafeArea())
        .safeAreaInset(edge: .bottom) { bottomBar }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: leadingPlacement) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                        Text("Genres")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                }
                .buttonStyle(.plain)
            }

            ToolbarItem(placement: trailingPlacement) {
                clearButton
            }
        }
        .navigationTitle("")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .tint(Theme.accent)
        .alert("Please select at least one genre", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
        .navigationDestination(isPresented: $goToMoviePage) {
            MovieRecPage(selectedGenres: Array(selectedGenres))
                .environmentObject(movieStore)
        }
    }

    private var leadingPlacement: ToolbarItemPlacement {
        #if os(iOS)
        return .topBarLeading
        #else
        return .navigation
        #endif
    }

    private var trailingPlacement: ToolbarItemPlacement {
        #if os(iOS)
        return .topBarTrailing
        #else
        return .automatic
        #endif
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("What are you feeling today?")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.black)

            Text(selectedGenres.isEmpty ? "Pick one or more genres." : "\(selectedGenres.count) selected")
                .font(.subheadline)
                .foregroundColor(Color.black.opacity(0.6))
        }
    }

    private var bottomBar: some View {
        VStack(spacing: 10) {
            Button { handleContinue() } label: {
                HStack {
                    Text("Continue")
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "arrow.right")
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(Theme.accent)
            .disabled(selectedGenres.isEmpty)
        }
        .padding(.horizontal)
        .padding(.top, 10)
        .padding(.bottom, 12)
        .background(Theme.surface)
        .overlay(Rectangle().frame(height: 1).foregroundColor(Theme.border), alignment: .top)
    }

    private var clearButton: some View {
        Button("Clear") {
            withAnimation(.spring(response: 0.22, dampingFraction: 0.95)) {
                selectedGenres.removeAll()
            }
        }
        .foregroundColor(.white)
        .bold()
        .buttonStyle(.plain)
        .disabled(selectedGenres.isEmpty)
    }

    private func toggleSelection(for genre: Genre) {
        withAnimation(.spring(response: 0.22, dampingFraction: 0.95)) {
            if selectedGenres.contains(genre) {
                selectedGenres.remove(genre)
            } else {
                selectedGenres.insert(genre)
            }
        }
    }

    private func handleContinue() {
        if selectedGenres.isEmpty {
            showAlert = true
        } else {
            goToMoviePage = true
        }
    }
}

struct GenreRowChip: View {
    let title: String
    let isSelected: Bool
    let accent: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSelected ? Theme.selectedText : .black)

                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(isSelected ? Theme.selectedText : .black)

                Spacer()
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
        }
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(isSelected ? Theme.chipSelected : Theme.chip)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Theme.border, lineWidth: 1)
        )
    }
}
