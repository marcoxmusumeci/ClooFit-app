//
//  ItemViewDetail.swift
//  ClooFit
//
//  Created by Paolo Sortino on 08/07/24.
//

import SwiftUI

// 167, 115
// 220, 168

struct ItemViewDetail: View {
    var item: article
        
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            ZStack {
                Rectangle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 340, height: 370) // Dimensioni fisse del contenitore
                
                item.image
                    .resizable()
                    .scaledToFit()
            }
            
            Text(item.mainColor.capitalized + " " + item.name.capitalized)
                .font(.largeTitle)
                .bold()
            Divider()
            HStack (alignment: .center){
                HStack {
                    Image(systemName: "tshirt")
                        .scaleEffect(1.5)
                    //.resizable()
                    //.frame(width: 30, height: 30)
                        //.padding()
                    Text("\(item.material.capitalized)")
                        .font(.system(size: 17))

                    //Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Image(systemName: "graduationcap")
                        .scaleEffect(1.5)
                    //.resizable()
                    //.frame(width: 30, height: 30)
                        //.padding()
                    Text("\(item.elegance.capitalized)")
                        .font(.system(size: 17))
                    //Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Image(systemName: "cloud.sun")
                        .scaleEffect(1.5)
                    //.resizable()
                    //.frame(width: 30, height: 30)
                        //.padding()
                    Text("\(item.weather.capitalized)")
                        .font(.system(size: 16))
                    //Spacer()
                }
                .padding(.horizontal)
            }
            
            
            Spacer()
        }
        .padding()
        // .navigationTitle(item.name)
    }
}



#Preview {
    ItemViewDetail(item: catalogo[73])
}
