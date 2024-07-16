
import SwiftUI


struct Palette: View {
    @State private var user = loadUserAttributes(from: "ddt.json") ?? UserAttributes(age: "18", hairColor: "Brown", skinColor: "1", stagione : 3, isTest: false) 
    private var mostraBanner: Bool{
        return !user.isTest
    }
     
    
    
    //1 Autumn, 2 Spring, 3 Summer, 4 Winter
    private var image: String {
        if mostraBanner {
            return "Default"
        } else {
            switch user.stagione {
            case 1:
                return "Autumn"
            case 2:
                return "Spring"
            case 3:
                return "Summer"
            case 4:
                return "Winter"
            default:
                return "Default"
            }
        }
    }
    
    private var palette: String {
        if mostraBanner {
            return "What are your colors?"
        } else {
            switch user.stagione {
            case 1:
                return "You're an Autumn"
            case 2:
                return "You're a Spring"
            case 3:
                return "You're a Summer"
            case 4:
                return "You're a Winter"
            default:
                return "What are your colors?"
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                
                
                // Top HStack with profile icon
                /* HStack {
                 Spacer() // To push the icon to the right
                 
                 Image(systemName: "person.circle")
                 .font(.system(size: 30))
                 .foregroundColor(Color(red: 60 / 255, green: 45 / 255, blue: 218 / 255))
                 .padding(.horizontal)
                 }
                 .padding(.top)*/
                
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        Spacer()
                        // Clothes Palette Section
                        VStack(alignment: .leading) {
                            
                            /*  Text("Clothes Palette")
                             .font(.title)
                             .fontWeight(.semibold)
                             .padding(.horizontal)*/
                            
                            HStack {
                                Image(image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height:  300)
                                    .padding(.horizontal)
                                
                            }
                            
                        }
                        
                        
                        
                        HStack{
                            Spacer()
                            Text(palette)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                                .padding(.horizontal)
                            Spacer()
                        }
                        
                        if mostraBanner{
                            // Banner Section
                            VStack {
                                
                                ZStack {
                                    // Background of the banner
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(Color(red: 60 / 255, green: 45 / 255, blue: 218 / 255))
                                        .frame(height: 150)
                                    
                                    
                                    // Banner content
                                    VStack(spacing: 10) {
                                        Text("Find out what your palettes are, to best match clothes")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                            .bold()
                                            .frame(width: 300, alignment: .leading)
                                        
                                        HStack {
                                            Text("Take the test")
                                                .font(.headline)
                                                .foregroundColor(.white.opacity(0.8))
                                                .padding(.horizontal)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.white)
                                                .font(.system(size: 20))
                                                .padding(.horizontal)
                                        }
                                    }
                                    
                                    .padding()
                                }
                                .padding(.horizontal)
                                .shadow(radius: 5)
                            }
                            .padding(.top)
                        }
                        else{
                            VStack {
                                NavigationLink(destination: ColorSelectionPage()) {
                                ZStack {
                                    
                                
                                        
                                        // Background of the banner
                                        RoundedRectangle(cornerRadius: 15)
                                            .foregroundColor(Color(red: 60 / 255, green: 45 / 255, blue: 218 / 255))
                                            .frame(height: 60)
                                        
                                        
                                        // Banner content
                                        VStack(alignment: .leading) {
                                            
                                            
                                            HStack {
                                                Text("Retake the test")
                                                    .font(.title2)
                                                    .bold()
                                                    .foregroundColor(.white.opacity(0.8))
                                                    .padding(.horizontal)
                                                
                                                Spacer()
                                                
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 20))
                                                    .padding(.horizontal)
                                            }
                                            
                                        }
                                        
                                        .padding()
                                    }}
                                .padding(.horizontal)
                                .shadow(radius: 5)
                            }
                            .padding(.top)
                        }
                        
                    }
                }
                
            }
            
            .navigationTitle("Your Palette")
        }
        
    }
}

#Preview {
    Palette()
}
