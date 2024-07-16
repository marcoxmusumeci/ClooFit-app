//
//  jsonFunction.swift
//  ClooFit
//
//  Created by Oteri Salvatore on 05/07/24.
//

import Foundation


//salva l'utente in un file json
func salvaUtente(user: UserAttributes, fileName: String){
    do {
        // Crea un'istanza di JSONEncoder
        let encoder = JSONEncoder()
        // Imposta l'opzione prettyPrinted per una migliore leggibilità
        encoder.outputFormatting = .prettyPrinted
        
        // Codifica l'array di utenti in dati JSON
        let jsonData = try encoder.encode(user)
        
        // Ottieni il percorso della directory dei documenti
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            // Crea il percorso completo del file
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            
            // Scrivi i dati JSON nel file
            try jsonData.write(to: fileURL)
            
            print("File JSON scritto con successo a: \(fileURL)")
            
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
    let subarray: [article] = array.filter{ $0.type == type}
   
    return subarray
}

/*func typeFilter(from array: [article], type: String) -> [article]? {
    var subarray: [article] = []
    for fit in array {
        if fit.type == type {
            subarray.append(fit)
        }
    }
    return subarray
}*/

// passa array article e filtra per eleganza passata (informal or formal)
func eleganceFilter(from array: [article], elegance: String) -> [article]? {
    let subarray: [article] = array.filter{ $0.elegance == elegance}
    return subarray
}

// passa array article e filtra per genere passata (man or woman or unisex) quelli unisex vengono sempre presi
func genderFilter(from array: [article], gender: String) -> [article]? {
    let subarray: [article] = array.filter{$0.gender == "unisex" || $0.gender == gender}
    return subarray
}

func weatherFilter(from array: [article], weather: String) -> [article]? {
    let subarray: [article] = array.filter{ $0.weather == weather}
    return subarray
}

//cerca per id
func cercaCapo(array:[article], id: String)-> article?{
    let ris: article? = array.first{$0.id == id}
    return ris
}

func getIndexCapo(array:[article], id: String)-> Int{
    var count = 0
    for fit in array {
        if (fit.id == id){
            return count
        }
        count += 1
    }
    return -1
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

func areColorsSimilar(color1: colorRGB, color2: colorRGB) -> Bool {
    var isComplementary: Bool
    var ris: Bool
    // Calcolare la tonalità complementare del primo colore
    //let complementaryHue = (color1.h + 180).truncatingRemainder(dividingBy: 360)
    // Controllare se la differenza di tonalità è vicina a 180 gradi
    let hueDifference = abs(color1.h - color2.h)
    
    let saturationDifference = abs(color1.s - color2.s)
    let isSaturationSimilar = saturationDifference < 0.3
        
        // Controllare se la luminosità è simile (entro un certo range)
    let lightnessDifference = abs(color1.l - color2.l)
    let isLightnessSimilar = lightnessDifference < 0.3
    
    // se è nero o bianco è compatibile
    if color1.l <= 0.1 || color1.l >= 0.9 || color2.l <= 0.1 || color2.l >= 0.9{
        ris = true
    }else{
        // altrimenti vedi se è più o meno un complementare facendo caso anche alla luminosità e alla saturazione
        isComplementary = hueDifference < 20 || hueDifference > 340
        ris = isComplementary && isSaturationSimilar && isLightnessSimilar
    }

    return ris
}

func readJSONFILE(fileName: String)-> UserAttributes?{
    if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        do{
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let user = try decoder.decode(UserAttributes.self, from: data)
            return user
        }
        catch{
            print("Failed to read JSon data: \(error.localizedDescription)")
        }
    }
    return nil
}
