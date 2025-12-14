import SwiftUI

private enum HomeTheme {
    static let bg1 = Color(red: 0.98, green: 0.97, blue: 0.99)
    static let bg2 = Color(red: 0.94, green: 0.98, blue: 1.00)
    static let subtitle = Color.black.opacity(0.62)
    static let pill = Color.white.opacity(0.92)
    static let border = Color.black.opacity(0.08)
}

struct ContentView: View {
    @EnvironmentObject var movieStore: MovieStore
    @State private var popIn = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [HomeTheme.bg1, HomeTheme.bg2],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 22) {
                Spacer()

                VStack(spacing: 10) {
                    Text("Movie Time")
                        .font(.system(size: 44, weight: .bold, design: .rounded))
                        .foregroundColor(.black)

                    Text("૮ ˶ᵔ ᵕ ᵔ˶ ა")
                        .font(.title3)
                        .foregroundColor(.gray)

                    Text("Pick a few genres and I’ll hand you a recommendation.")
                        .font(.subheadline)
                        .foregroundColor(HomeTheme.subtitle)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 28)
                }
                .opacity(popIn ? 1 : 0)
                .offset(y: popIn ? 0 : 14)

                NavigationLink {
                    GenreSelect()
                        .environmentObject(movieStore)
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "sparkles")
                        Text("start")
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 22)
                    .padding(.vertical, 14)
                    .background(
                        Capsule()
                            .fill(HomeTheme.pill)
                            .overlay(Capsule().stroke(HomeTheme.border, lineWidth: 1))
                    )
                }
                .buttonStyle(.plain)
                .foregroundColor(.black)
                .shadow(color: Color.black.opacity(0.08), radius: 14, x: 0, y: 10)
                .scaleEffect(popIn ? 1 : 0.96)
                .opacity(popIn ? 1 : 0)

                Text("made for indecisive nights")
                    .font(.caption)
                    .foregroundColor(HomeTheme.subtitle)
                    .opacity(popIn ? 1 : 0)
                    .offset(y: popIn ? 0 : 10)

                Spacer()
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // <-- forces full-screen layout
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.85)) {
                popIn = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .environmentObject(MovieStore())
    }
}
