import SwiftUI

private enum HomeTheme {
    static let bg1 = Color(red: 0.98, green: 0.97, blue: 0.99)
    static let bg2 = Color(red: 0.94, green: 0.98, blue: 1.00)
    static let subtitle = Color.black.opacity(0.62)
    static let pill = Color.white.opacity(0.92)
    static let border = Color.black.opacity(0.08)
    static let accent = Color(red: 0.36, green: 0.56, blue: 0.98)
}

struct ContentView: View {
    @EnvironmentObject var movieStore: MovieStore
    @State private var popIn = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [HomeTheme.bg1, HomeTheme.bg2],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 18) {
                    VStack(spacing: 8) {
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
                            .padding(.horizontal, 22)
                    }
                    .opacity(popIn ? 1 : 0)
                    .offset(y: popIn ? 0 : 12)
                    
                    NavigationLink {
                        GenreSelect()
                            .environmentObject(movieStore)
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "sparkles")
                                .imageScale(.medium)
                            
                            Text("start")
                                .fontWeight(.semibold)
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 12)
                        .background(
                            Capsule()
                                .fill(HomeTheme.pill)
                                .overlay(
                                    Capsule().stroke(HomeTheme.border, lineWidth: 1)
                                )
                        )
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(.black)
                    .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 8)
                    .scaleEffect(popIn ? 1 : 0.97)
                    .opacity(popIn ? 1 : 0)
                    
                    Text("made for indecisive nights")
                        .font(.caption)
                        .foregroundColor(HomeTheme.subtitle)
                        .opacity(popIn ? 1 : 0)
                        .offset(y: popIn ? 0 : 14)
                        .padding(.top, 2)
                    
                    Spacer()
                }
                .padding(.top, 90)
            }
            .navigationTitle("")
            .onAppear {
                withAnimation(.spring(response: 0.48, dampingFraction: 0.86)) {
                    popIn = true
                }
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(MovieStore())
}
