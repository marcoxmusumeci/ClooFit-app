import SwiftUI

struct UpperSwipeView: View {
    var items: [article]
    @Binding var currentPage: Int
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentPage) {
                ForEach(0..<items.count, id: \.self) { index in
                    if index < items.count {
                        items[index].image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 230)
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 180)
        }
    }
}

struct LowerSwipeView: View {
    var items: [article]
    @Binding var currentPage: Int
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentPage) {
                ForEach(0..<items.count, id: \.self) { index in
                    if index < items.count {
                        items[index].image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 250)
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 250)
            .offset(y: -50)
        }
    }
}

struct ChooseAnOutfit: View {
    @State var vestiti_eleganti: Bool
    @State var upperSelected: article
    @State var lowerSelected: article
    @State var currentUpperIndex: Int
    @State var currentLowerIndex: Int
    @State var currentFormalUpperIndex = 0
    @State var currentInformalUpperIndex = 0
    @State var currentFormalLowerIndex = 0
    @State var currentInformalLowerIndex = 0
    @State var selectedWeather: String = "hot"
    
    @State private var navigateToContentView = false
    @State private var showAlert = false
    
    @State private var uppers: [article]?
    @State private var lowers: [article]?
    
    init(vestiti_eleganti: Bool, upperSelected: article, lowerSelected: article) {
        self.vestiti_eleganti = vestiti_eleganti
        self.upperSelected = upperSelected
        self.lowerSelected = lowerSelected
        
        let uppersUnfiltered = typeFilter(from: catalogo, type: "top")
        let uppersUnfiltered2 = genderFilter(from: uppersUnfiltered ?? [], gender: user.gender ?? "")
        let lowersUnfiltered = typeFilter(from: catalogo, type: "bottom")
        let lowersUnfiltered2 = genderFilter(from: lowersUnfiltered ?? [], gender: user.gender ?? "")
        
        self.currentUpperIndex = getIndexCapo(array: uppersUnfiltered2 ?? [], id: upperSelected.id)
        self.currentLowerIndex = getIndexCapo(array: lowersUnfiltered2 ?? [], id: lowerSelected.id)
        
        if vestiti_eleganti {
            self.currentFormalUpperIndex = currentUpperIndex
            self.currentFormalLowerIndex = currentLowerIndex
        } else {
            self.currentInformalUpperIndex = currentUpperIndex
            self.currentInformalLowerIndex = currentLowerIndex
        }
        
        updateArticles()
    }
    
    var body: some View {
        VStack {
            UpperSwipeView(items: uppers ?? [], currentPage: $currentUpperIndex)
                .padding(.bottom, 10)
            
            LowerSwipeView(items: lowers ?? [], currentPage: $currentLowerIndex)
                .padding(.bottom, 10)
            
            VStack(alignment: .leading) {
                MeteoView()
                    .offset(x: 12, y: -20)
                
                HStack {
                    Image(systemName: "puzzlepiece.extension.fill")
                        .imageScale(.large)
                        .padding(.horizontal, 10)
                    Toggle("Formal Event", isOn: $vestiti_eleganti)
                        .onChange(of: vestiti_eleganti) { _ in updateArticles() }
                }
            }
            .padding()
        }
        .onAppear { initializeArticles() }
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    if let uppers = uppers, uppers.indices.contains(currentUpperIndex) {
                        closet.append(uppers[currentUpperIndex])
                        aggiungiAlArmadio(vestito: uppers[currentUpperIndex])
                    } else {
                        print("Lista vuota o indice non valido")
                    }
                    
                    if let lowers = lowers, lowers.indices.contains(currentLowerIndex) {
                        closet.append(lowers[currentLowerIndex])
                        aggiungiAlArmadio(vestito: lowers[currentLowerIndex])
                    } else {
                        print("Lista vuota o indice non valido")
                    }
                    showAlert = true
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Saved"),
                message: Text("Articles have been saved into your closet."),
                dismissButton: .default(Text("OK")) {
                    navigateToContentView = true
                }
            )
        }
        .background(
            NavigationLink(destination: ContentView(), isActive: $navigateToContentView) {
                EmptyView()
            }
                .hidden()
        )
        .fullScreenCover(isPresented: $navigateToContentView) {
            ContentView()
        }
    }
    
    func initializeArticles() {
        updateArticles()
    }
    
    func updateArticles() {
        let uppersUnfiltered = typeFilter(from: catalogo, type: "top")
        let uppersUnfiltered2 = genderFilter(from: uppersUnfiltered ?? [], gender: user.gender ?? "")
        let uppersFilteredByWeather = weatherFilter(from: uppersUnfiltered2 ?? [], weather: selectedWeather)
        
        let lowersUnfiltered = typeFilter(from: catalogo, type: "bottom")
        let lowersUnfiltered2 = genderFilter(from: lowersUnfiltered ?? [], gender: user.gender ?? "")
        let lowersFilteredByWeather = weatherFilter(from: lowersUnfiltered2 ?? [], weather: selectedWeather)
        
        if vestiti_eleganti {
            uppers = eleganceFilter(from: uppersFilteredByWeather ?? [], elegance: "formal")
            lowers = eleganceFilter(from: lowersFilteredByWeather ?? [], elegance: "formal")
            currentFormalUpperIndex = currentUpperIndex
            currentFormalLowerIndex = currentLowerIndex
        } else {
            uppers = eleganceFilter(from: uppersFilteredByWeather ?? [], elegance: "informal")
            lowers = eleganceFilter(from: lowersFilteredByWeather ?? [], elegance: "informal")
            currentInformalUpperIndex = currentUpperIndex
            currentInformalLowerIndex = currentLowerIndex
        }
        
        // Verifica e correggi gli indici se fuori dall'intervallo
        if let uppers = uppers {
            if !uppers.indices.contains(currentUpperIndex) {
                currentUpperIndex = 0
            }
        }
        
        if let lowers = lowers {
            if !lowers.indices.contains(currentLowerIndex) {
                currentLowerIndex = 0
            }
        }
        
        if vestiti_eleganti {
            currentUpperIndex = currentFormalUpperIndex
            currentLowerIndex = currentFormalLowerIndex
        } else {
            currentUpperIndex = currentInformalUpperIndex
            currentLowerIndex = currentInformalLowerIndex
        }
    }
}
