import SwiftUI

struct MovieCardView: View {
    let movie: Movies
    let onAddToCart: () -> Void
    @State private var showAddToCartAnim: Bool = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            NavigationLink(destination: MovieDetailView(movie: movie)) {
                AsyncImage(url: URL(string: Endpoints.getMovieImage(named: movie.image))) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.3))
                }
                .frame(width: 140, height: 210)
                .cornerRadius(10)
            }
            .buttonStyle(.plain)

            Button(action: {
                HapticsManager.shared.notify(.success)
                onAddToCart()
                withAnimation(.easeOut(duration: 0.2)) { showAddToCartAnim = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    withAnimation(.easeIn(duration: 0.2)) { showAddToCartAnim = false }
                }
            }) {
                Image(systemName: "cart.badge.plus")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.theme.logo)
                    .clipShape(Circle())
            }
            .padding(8)
            .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 5)

            .overlay(
                    ZStack {
                        if showAddToCartAnim {
                            LottieView(fileName: "Add To Cart Success")
                                .frame(width: 70, height: 70)
                                .transition(.scale)
                        }
                    }
                    )
        }
        .shadow(radius: 5)
    }
}

// Preview kodunuzda bir sorun yok, o yüzden olduğu gibi kalabilir.
struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMovie = Movies(id: 10,
                                 name: "Dune",
                                 image: "dune.png",
                                 price: 19,
                                 category: "Science Fiction",
                                 rating: 8.0,
                                 year: 2021,
                                 director: "Denis Villeneuve",
                                 description: "Lorem ipsum...")
        
        MovieCardView(movie: sampleMovie, onAddToCart: {
            print("\(sampleMovie.name) filmine tıklandı ve sepete eklenecek.")
        })
        .environmentObject(CartViewModel())
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
