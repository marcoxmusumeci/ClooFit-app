//
//  File.swift
//  ClooFit
//
//  Created by Gabriele Faraone on 07/07/24.
//

import Foundation


var armadio: [article] = load("armadio.json")


func salvaArmadio(){
    do {
        // Crea un'istanza di JSONEncoder
        let encoder = JSONEncoder()
        // Imposta l'opzione prettyPrinted per una migliore leggibilità
        encoder.outputFormatting = .prettyPrinted
        
        // Codifica l'array di utenti in dati JSON
        let jsonData = try encoder.encode(armadio)
        
        // Ottieni il percorso della directory dei documenti
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            // Crea il percorso completo del file
            let jsonFilePath = documentDirectory.appendingPathComponent("armadio.json")
            
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




// fare funzioni per il salvataggio dei capi nel mio armadio personale, gia quella che c'è

// funzione

func aggiungiAlArmadio(vestito: article) {
    if !armadio.contains(where: { $0.id == vestito.id }) {
        armadio.append(vestito)
        print("Aggiunto l'ID \(vestito.id) all'armadio.")
    } else {
        print("L'ID \(vestito.id) è già presente nell'armadio.")
    }
}

func rimuoviDaArmadio(vestito: article) {
    let initialCount = armadio.count
    armadio.removeAll(where: { $0.id == vestito.id })
    if armadio.count < initialCount {
        print("Rimosso l'articolo con ID \(vestito.id) dall'armadio.")
    } else {
        print("L'articolo con ID \(vestito.id) non è presente nell'armadio.")
    }
}





