import SwiftUI

struct BodyShapePage2: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("Face ID 1-3")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 320)
                    .padding(.vertical, -1)
                Spacer()
                
                Text("Choose your \n palette")
                    .font(.system(size: 40, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.vertical, 3)
                    .foregroundColor(Color.primary) // Usa Color.primary per il colore del testo
                    .accessibility(addTraits: .isHeader) // Aggiunge l'attributo di accessibilità per le intestazioni
                
                Text("Select the colors for armochromy analysis")
                    .font(.system(size: 15, weight: .light))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 0.5)
                    .foregroundColor(Color.secondary) // Usa Color.secondary per il colore del testo in modalità chiara
                    .accessibility(addTraits: .isHeader) // Aggiunge l'attributo di accessibilità per le intestazioni
                
                Spacer()
                
                NavigationLink(destination: ColorSelectionPage()) {
                    Text("Next")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "3C2DDA"))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .padding(.horizontal)
                }
                .padding(.bottom)
            }
            .padding()
            .navigationBarItems(trailing: Button(action: {
                // Azione per passare alla pagina successiva
                if let window = UIApplication.shared.windows.first {
                    window.rootViewController = UIHostingController(rootView: ColorSelectionPage())
                    window.makeKeyAndVisible()
                }
            }) {
                
            })
           
            .gesture(DragGesture().onEnded({ (gesture) in
                if gesture.translation.width > 100 {
                    // Esegui l'azione di swipe right per tornare indietro
                    // Per esempio, potresti usare presentationMode o un binding per gestire la navigazione
                }
            }))
            .preferredColorScheme(.light) // Imposta lo schema di colori preferito a light
            
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Stile della navigation view
        .navigationBarBackButtonHidden(true)

        .preferredColorScheme(.light) // Imposta lo schema di colori preferito a light
    }
}

