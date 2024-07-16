//
//  NewOutfitRow.swift
//  ClooFit
//
//  Created by Claudio Sottile on 09/07/24.
//

import SwiftUI

struct NewOutfitRow: View {
    var body: some View {
        VStack (alignment: .center) {
            Image(systemName: "plus.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.top, 20)
            Text("Create a New Outfit")
                .font(.headline)
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
        }
        .frame(maxWidth: .infinity)
        .background(Color(red: (57.0 / 255.0), green: (46.0 / 255.0), blue: (210.0/255.0)))
        .foregroundColor(.white)
        .shadow(radius: 5)
        .cornerRadius(10)
        .padding(.horizontal, 30)
    }
}

#Preview {
    NewOutfitRow()
}
