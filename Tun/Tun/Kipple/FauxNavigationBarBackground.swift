
import SwiftUI

struct FauxNavigationBarBackground<Content>: View where Content: View {
    private let content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                self.content()
                    .frame(height: geometry.safeAreaInsets.top)
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
    
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
}

// MARK: - Extensions

extension FauxNavigationBarBackground where Content == VisualEffectView {
    init() {
        self.init {
            VisualEffectView(effect: UIBlurEffect(style: .regular))
        }
    }
}

extension View {
    func withFauxNaivgationBarBackground() -> some View {
        self.overlay(FauxNavigationBarBackground())
    }
    
    func withFauxNaivgationBarBackground<Content>(@ViewBuilder _ content: @escaping () -> Content) -> some View where Content: View {
        self.overlay(FauxNavigationBarBackground(content))
    }
}

// MARK: - Previews

struct FauxNavigationBarBackground_Previews: PreviewProvider {
    private static let displayModes: [NavigationBarItem.TitleDisplayMode] = [
        .inline,
        .large,
    ]
    
    static var previews: some View {
        ForEach(self.displayModes, id: \.self) { displayMode in
            NavigationView {
                ZStack {
                    FauxNavigationBarBackground {
                        Color.blue
                    }
                    
                    Text("View")
                }
                .navigationTitle("Title")
                .navigationBarTitleDisplayMode(displayMode)
            }
        }
        .previewMatrix(.currentDevice)
    }
}
