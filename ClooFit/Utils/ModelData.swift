//
//  ModelData.swift
//  ClooFit
//
//  Created by Oteri Salvatore on 05/07/24.
//

import Foundation

class Closet: ObservableObject {
    @Published var items: [article] = []
    
    func add(_ item: article) {
        items.append(item)
    }
}

var catalogo: [article] = load("clothes.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
    
}
