//
//  stagione.swift
//  ClooFit
//
//  Created by Gabriele Faraone on 10/07/24.
//

import Foundation


/*func caricaEUppdateuserDaFile() -> user? {
    do {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let jsonFilePath = documentDirectory.appendingPathComponent("user.json")
            let jsonData = try Data(contentsOf: jsonFilePath)
            let decoder = JSONDecoder()
            var user = try decoder.decode(user.self, from: jsonData)
            
            // Determina la stagione
            let stagione = getStagione(occhi: user.eyeColor, capelli: user.hairColor, pelle: user.skinColor)
            user.stagione = stagione
            
            // Salva i dati aggiornati nel file JSON
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let updatedJsonData = try encoder.encode(user)
            try updatedJsonData.write(to: jsonFilePath)
            
            return user
        }
    } catch {
        print("Errore durante il caricamento o aggiornamento del file JSON: \(error.localizedDescription)")
    }
    return nil
}*/

/*let eyeColors = ["Brown", "Blue", "Green"]
let hairColors = ["Black", "Brown", "Blonde", "Red", "Gray", "Bald"]
let skinColors = ["Skin Color 1", "Skin Color 2", "Skin Color 3"]*/

func caricaEUpdateStagioneDaFile() -> Int? {
    if  user.eyeColor != nil && user.hairColor != nil && user.skinColor != nil {
        return getStagione(occhi: user.eyeColor!, capelli: user.hairColor!, pelle: user.skinColor!)
    }
    return 0
}


func getStagione(occhi: String, capelli: String, pelle: String) -> Int {
    switch (occhi, capelli, pelle) {
        case ("Brown", "Black", "Skin Color 3"), ("Brown", "Black", "Skin Color 2"):
            return 1 // Autunno
        case ("Blue", "Blonde", "Skin Color 1"), ("Blue", "Gray", "Skin Color 1"):
            return 2 // Primavera
        case ("Green", "Red", "Skin Color 1"), ("Green", "Blonde", "Skin Color 2"):
            return 3 // Estate
        case ("Brown", "Gray", "Skin Color 3"), ("Brown", "Gray", "Skin Color 2"):
            return 4 // Inverno
        default:
            return 1 // Default to Autunno if no match is found
    }
}

