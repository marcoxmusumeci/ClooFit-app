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
                    Circle().fill(Color(red: outfit.upper.mainColorRGB.norm_r, green: outfit.upper.mainColorRGB.norm_g, blue: outfit.upper.mainColorRGB.norm_b))
                        .frame(width: 20)
                        .padding()
                    Text(outfit.upper.mainColor.capitalized)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, -10)
                        .foregroundColor(.black)
                    
                }
                HStack {
                    Circle().fill(Color(red: outfit.lower.mainColorRGB.norm_r, green: outfit.lower.mainColorRGB.norm_g, blue: outfit.lower.mainColorRGB.norm_b))
                        .frame(width: 20)
                        .padding()
                    Text(outfit.lower.mainColor.capitalized)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, -10)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            // Images
            
            VStack {
                outfit.upper.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 143, height: 98)
                    .shadow(radius: 5)
                    .padding()
                outfit.lower.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .offset(x: -1, y: -35)
                    .padding(.bottom, -35)
                    .shadow(radius: 5)
            }
        }
        .background(Color(red: (245.0 / 255.0), green: (245.0 / 255.0), blue: (247.0/255.0)))
        .cornerRadius(10)
        .padding(.horizontal, 30)
    }
}

#Preview {
    //SuggestionRow(outfit: Outfit(upper: Article(id: 0, path: "SO01", red: 33, green: 33, blue: 33, colorLabel: "Black"), lower: Article(id: 1, path: "SO31", red: 35, green: 44, blue: 49, colorLabel: "Blue")))
    Group {
        SuggestionRow(outfit: Outfit(upper: catalogo[2], lower: catalogo[27]))
        SuggestionRow(outfit: Outfit(upper: catalogo[3], lower: catalogo[28]))
        SuggestionRow(outfit: Outfit(upper: catalogo[4], lower: catalogo[29]))
    }
}
