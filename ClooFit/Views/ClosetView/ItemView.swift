//
//  ItemView.swift
//  ClooFit
//
//  Created by Paolo Sortino on 05/07/24.
//

import SwiftUI

// 167, 115
// 220, 168

struct ItemView: View {
    var item: article
    let myGray : Color = Color(red: (245.0 / 255.0), green: (245.0 / 255.0), blue: (247.0/255.0))
    var body: some View {
        ZStack {
            myGray
                .frame(width: 220, height: 170)
                .cornerRadius(20)
                .shadow(radius: 5)
            item.image
                .resizable()
                .frame(width: 150, height: 150)
        }
    }
}

#Preview {
    ItemView(item: catalogo[0])
}

