//
//  SuggestionRow.swift
//  ClooFit
//
//  Created by Claudio Sottile on 04/07/24.
//

import SwiftUI

struct SuggestionRow: View {
    
    var outfit: Outfit
    
    var body: some View {
        HStack {
            
            // Color preview and color label
            
            VStack (alignment: .leading){
                HStack {
                    Circle().fill(Color(red: outfit.upper.redNormalized, green: outfit.upper.blueNormalized, blue: outfit.upper.greenNormalized))
                        .frame(width: 20)
                        .padding()
                    Text(outfit.upper.colorLabel)
                        .padding(.horizontal, -10)
                }
                HStack {
                    Circle().fill(Color(red: outfit.lower.redNormalized, green: outfit.lower.blueNormalized, blue: outfit.lower.greenNormalized))
                        .frame(width: 20)
                        .padding()
                    Text(outfit.lower.colorLabel)
                        .padding(.horizontal, -10)
                }
                
            }
            
            Spacer()
            
            // Images
            
            VStack {
                outfit.upper.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 136, height: 91)
                    .shadow(radius: 5)
                outfit.lower.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 102, height: 102)
                    .offset(y: -25)
                    .padding(.bottom, -1)
                    .shadow(radius: 5)
            }
        }
        .background(Color(red: (245.0 / 255.0), green: (245.0 / 255.0), blue: (247.0/255.0)))
        .cornerRadius(10)
        .padding(.all, 30)
    }
}

#Preview {
    SuggestionRow(outfit: Outfit(upper: Article(id: 0, path: "Black", red: 33, green: 33, blue: 33, colorLabel: "Black"), lower: Article(id: 1, path: "Pants", red: 35, green: 44, blue: 49, colorLabel: "Blue")))
}
