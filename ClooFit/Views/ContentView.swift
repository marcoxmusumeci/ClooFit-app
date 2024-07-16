//
//  ContentView.swift
//  ClooFit
//
//  Created by Claudio Sottile on 28/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomePage()
                .tabItem {
                    Label("Outfits", systemImage: "tshirt.fill")
                }
                .tag(0)
            ClosetView()
                .tabItem {
                    Label("Closet", systemImage: "tag")
                        
                }
                .tag(1)
            Palette()
                .tabItem {
                    Label("Colors", systemImage: "rays")
                        .tag(2)
                }
                
        }
        .accentColor(Color(red: 60 / 255, green: 45 / 255, blue: 218 / 255))
    }
}

#Preview {
    ContentView()
        .accentColor(Color(red: 60 / 255, green: 45 / 255, blue: 218 / 255))
}
