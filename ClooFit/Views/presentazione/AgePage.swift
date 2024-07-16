import SwiftUI

struct AgePage: View {
    @State private var selectedAge: String? = nil
    let ageOptions = ["< 18", "18-25", "25+"]

    var body: some View {
        VStack {
            // Progress bar above the text
            ProgressBar(progress: 0.66)
                .frame(height: 8)
                .padding(.horizontal, 80) // Adjust horizontal padding

            VStack {
                Text("Age")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)

                Text("Select your age")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.top, -16)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 33)
                    .padding(.bottom, 20)
            }
            .padding(.top, 20) // Add additional top padding

            Spacer()

            VStack {
                ForEach(ageOptions, id: \.self) { option in
                    Button(action: {
                        selectedAge = option
                    }) {
                        Text(option)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 90)
                            .background(selectedAge == option ? Color(hex: "847BE2") : Color(hex: "DEDBF4"))
                            .foregroundColor(.black)
                            .cornerRadius(31)
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 50)
                }
            }
            .padding(.horizontal, 40)

            Spacer()
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: BodyShapePage2()) {
                    Text("Next")
                        .font(.headline)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 56)
                        .background(selectedAge != nil ? Color(hex: "3C2DDA") : Color(hex: "9D96EC"))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .opacity(selectedAge != nil ? 1.0 : 1.0)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    if let age = selectedAge {
                        writeAgeToFile(age: age)
                    }
                })
                .disabled(selectedAge == nil)
                .padding(.bottom, 13)
                .padding(.trailing, 24)
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .gesture(DragGesture().onEnded({ (gesture) in
            if gesture.translation.width > 100 {
                // Perform swipe right action for going back
                // For example, you might use a presentationMode or a binding to manage navigation
            }
        }))
        .preferredColorScheme(.light) // Ensure consistent color scheme
    }
}

struct ProgressBar: View {
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

func writeAgeToFile(age: String) {
    let ageData = ["selectedAge": age]
    
    if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentDirectory.appendingPathComponent("ddt.json")
        
        do {
            var existingData = [String: Any]()
            
            if let data = try? Data(contentsOf: fileURL),
               let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                existingData = jsonData
            }
            
            existingData.merge(ageData) { (_, new) in new }
            
            let data = try JSONSerialization.data(withJSONObject: existingData, options: .prettyPrinted)
            try data.write(to: fileURL)
            print("Data saved to \(fileURL)")
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
}


