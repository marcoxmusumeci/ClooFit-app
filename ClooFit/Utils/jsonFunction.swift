//
//  jsonFunction.swift
//  ClooFit
//
//  Created by Oteri Salvatore on 05/07/24.
//

import Foundation

//salva l'utente in un file json
func salva(users: Utente){
    do {
        // Crea un'istanza di JSONEncoder
        let encoder = JSONEncoder()
        // Imposta l'opzione prettyPrinted per una migliore leggibilità
        encoder.outputFormatting = .prettyPrinted
        
        // Codifica l'array di utenti in dati JSON
        let jsonData = try encoder.encode(users)
        
        // Ottieni il percorso della directory dei documenti
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            // Crea il percorso completo del file
            let jsonFilePath = documentDirectory.appendingPathComponent("Utente.json")
            
            // Scrivi i dati JSON nel file
            try jsonData.write(to: jsonFilePath)
            
            print("File JSON scritto con successo a: \(jsonFilePath)")
            
            // Per visualizzare il JSON in formato stringa
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Contenuto del file JSON:\n\(jsonString)")
            }
        }
    } catch {
        print("Errore durante la scrittura del file JSON: \(error.localizedDescription)")
    }
}

// passa array article e filtra per tipo passato (top or bottom or topbottom)
func typeFilter(from array: [article], type: String) -> [article]? {
    var subarray: [article] = []
    for articolo in array{
        if(articolo.type == type){
            subarray.append(articolo)
        }
    }
    return subarray
}

// passa array article e filtra per eleganza passata (informal or formal)
func eleganceFilter(from array: [article], elegance: String) -> [article]? {
    var subarray: [article] = []
    for articolo in array{
        if(articolo.elegance == elegance){
            subarray.append(articolo)
        }
    }
    return subarray
}

// passa array article e filtra per genere passata (man or woman or unisex) quelli unisex vengono sempre presi
func genderFilter(from array: [article], gender: String) -> [article]? {
    var subarray: [article] = []
    for articolo in array{
        if( articolo.gender == "unisex" || articolo.gender == gender){
            subarray.append(articolo)
        }
    }
    return subarray
}




//vede se è abbinabile il colore (semplicemnte vedendo se è un suo complemntare più o meno)
//da usare con cura
func areColorsHarmonious(upper: article, lower: article) -> Bool {
    var isComplementary: Bool
    var ris: Bool
    // Calcolare la tonalità complementare del primo colore
    let complementaryHue = (upper.mainColorRGB.h + 180).truncatingRemainder(dividingBy: 360)
    // Controllare se la differenza di tonalità è vicina a 180 gradi
    let hueDifference = abs(complementaryHue - lower.mainColorRGB.h)
    
    let saturationDifference = abs(upper.mainColorRGB.s - lower.mainColorRGB.s)
    let isSaturationSimilar = saturationDifference < 0.3
        
        // Controllare se la luminosità è simile (entro un certo range)
    let lightnessDifference = abs(upper.mainColorRGB.l - lower.mainColorRGB.l)
    let isLightnessSimilar = lightnessDifference < 0.3
    
    // se è nero o bianco è compatibile
    if upper.mainColorRGB.l <= 0.1 || upper.mainColorRGB.l >= 0.9 || lower.mainColorRGB.l <= 0.1 || lower.mainColorRGB.l >= 0.9{
        ris = true
    }else{
        // altrimenti vedi se è più o meno un complementare facendo caso anche alla luminosità e alla saturazione
        isComplementary = hueDifference < 20 || hueDifference > 340
        ris = isComplementary && isSaturationSimilar && isLightnessSimilar
    }

    return ris
}
