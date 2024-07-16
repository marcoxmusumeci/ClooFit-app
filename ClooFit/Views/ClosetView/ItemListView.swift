//
//  ItemListView.swift
//  ClooFit
//
//  Created by Paolo Sortino on 05/07/24.
//

import SwiftUI

var closet: [article] = []



// Funzione per ottenere i diversi tipi di 'name'
func getUniqueNames(from articles: [article]) -> Set<String> {
    var uniqueNames = Set<String>()
    for article in articles {
        uniqueNames.insert(article.name)
    }
    return uniqueNames
}

// funzione che filtra gli articoli della lista articles per name
func getArticles(ofType type: String, from articles: [article]) -> [article] {
    let filtered = articles.filter { $0.name == type }
    return filtered
}

struct ItemListView: View {
    let filteredList : [article]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing:10) {
                ForEach(filteredList) { article in
                    //ItemView(item: article)
                    NavigationLink(destination: ItemViewDetail(item: article)) {
                        ItemView(item: article)
                    }
                }
            }
            .padding()
        }
    }
}

struct CategoryView: View {
    var typeName: String
    
    var body: some View {
        let filteredList: [article] = getArticles(ofType: typeName, from: closet)
        VStack(alignment: .leading) {
            Text(typeName.capitalized)
                .font(.title)
                .bold()
                .padding(.leading)
            ItemListView(filteredList: filteredList)
        }
        .frame(height: 270)
    }
}
/*
struct ClosetView: View {
    
    let differentTypes = getUniqueNames(from: closet)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 80) {
            Text("Your Closet")
                .font(.largeTitle)
                .bold()
                .padding(.leading)
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(Array(differentTypes), id: \.self) {
                    type in
                    CategoryView(typeName: type)
                }
                Spacer()
            }
        }.padding(.top, 80)
    }
}
*/
struct ClosetView: View {
    let differentTypes = getUniqueNames(from: closet)
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 80) {
                /*
                Text("Your Closet")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading)
                */
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(Array(differentTypes), id: \.self) { type in
                            CategoryView(typeName: type)
                    }
                    Spacer()
                }
                .navigationTitle("Your Closet")
            }
            .padding(.top, 80)
        }
    }
}

#Preview {
    // ItemListView(filteredList: closet)
    // CategoryView(typeName: "pants")
    ClosetView()
}
