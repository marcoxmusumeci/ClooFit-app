import SwiftUI
import Foundation

struct GenderPage: View {
    @State private var selectedGender: String?
    
    let genderOptions = [
        ("man", "male_image1"),    // Replace with actual image names
        ("woman", "female_image1") // Replace with actual image names
    ]
    
    @State private var progressBarWidth: CGFloat = 100
    @State private var progressBarHeight: CGFloat = 4
    
    var body: some View {
        VStack {
            // Progress indicator (customizable dimensions)
            CustomProgressBar(progress: 0.33)
                .frame(height: 8)
                .padding(.horizontal, 80) // Adjust horizontal padding to match the original

            Spacer()
            
            // Title and subtitle (updated styling)
            VStack(spacing: 8) {
                Text("Style")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Select the style with which you identify yourself")
                    .font(.body) // Adjusted to body font size
                    .foregroundColor(.secondary) // Thinner appearance
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    
            }
            .padding(.horizontal)
            .padding(.vertical, -36)
            Spacer()
            
            // Gender selection options with larger images
            VStack(spacing: 40) {
                ForEach(genderOptions, id: \.0) { option in
                    Button(action: {
                        selectedGender = option.0
                    }) {
                        VStack {
                            Image(option.1) // Load custom image from asset catalog
                                .resizable()
                                .scaledToFit()
                                .frame(width: 140, height: 140) // Larger images
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(selectedGender == option.0 ? Color(hex: "3C2DDA") : Color.clear, lineWidth: 4)
                                )
                            Text(option.0)
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
            
            // "Next" button (smaller and fixed to bottom right)
            HStack {
                Spacer()
                NavigationLink(destination: AgePage(), label: {
                    Text("Next")
                        .font(.headline)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 56)
                        .background(Color(hex: "3C2DDA"))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .opacity(selectedGender != nil ? 1.0 : 0.5) // Disable if gender not selected
                })
                .simultaneousGesture(TapGesture().onEnded {
                    if let gender = selectedGender {
                        saveGenderToFile(gender: gender)
                    }
                })
                .disabled(selectedGender == nil)
                .padding(.bottom, 13)
                .padding(.trailing, 24)
            }
            
        }
        .padding()
        .navigationBarBackButtonHidden(true) // Hide the back button
        .gesture(DragGesture().onEnded({ (gesture) in
            if gesture.translation.width > 100 {
                // Perform swipe right action for going back
                // For example, you might use a presentationMode or a binding to manage navigation
            }
        }))
        .preferredColorScheme(.light)
    }
}

struct CustomProgressBar: View {
    var progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .opacity(0.3)
                    .foregroundColor(Color.gray)

                Rectangle()
                    .frame(width: geometry.size.width * progress, height: geometry.size.height) // Adjusted width calculation
                    .foregroundColor(Color(hex: "3C2DDA")) // Custom color for the progress bar
            }
            .cornerRadius(5.0)
        }
        .frame(height: 8) // Ensure a fixed height for the progress bar
    }
}

// Funzione per salvare il genere selezionato in stats.json
func saveGenderToFile(gender: String) {
    let selections = ["selectedGender": gender]
    
    if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentDirectory.appendingPathComponent("ddt.json")
        
        do {
            let data = try JSONSerialization.data(withJSONObject: selections, options: .prettyPrinted)
            try data.write(to: fileURL)
            print("Gender saved to \(fileURL)")
        } catch {
            print("Failed to save gender: \(error.localizedDescription)")
        }
    }
}

