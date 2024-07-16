import SwiftUI

struct WelcomePage: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("welcome_image") // Make sure the image is added to the asset catalog with the name "welcome_image"
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 320) // Adjust the height as needed
                
                Spacer()
                
                Text("Cloofit an app for outfits")
                    .font(.system(size: 40, weight: .bold)) // Increase the font size
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .foregroundColor(.primary) // Ensure text color remains consistent
                
                Text("Create your unique style and \n reach the best with a click")
                    .font(.system(size: 15, weight: .light)) // Make the text lighter
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 0.5) // Add more space between the two text elements
                    .foregroundColor(.secondary) // Ensure text color remains consistent
                
                Spacer()
                
                NavigationLink(destination: GenderPage()) {
                    Text("Next")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "3C2DDA")) // Use Color directly or with your extension
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .padding(.horizontal)
                }
                .padding(.bottom)
            }
            .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Adjust navigation view style as needed
        .preferredColorScheme(.light) // Ensure light mode to maintain explicit colors
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
