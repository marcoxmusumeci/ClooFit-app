
import Foundation
import SwiftUI


  
 
  
  func aggiungiAlArmadio(vestito: article) {
      if !(closet.contains { $0.id == vestito.id }) && vestito.id != "SO00U" && vestito.id != "SO00L" {
          closet.append(vestito)
          salvaArmadio()
      } else {
          print("L'ID \(vestito.id) è già presente nell'armadio o non è valido.")
      }
  }
  
  func rimuoviDaArmadio(vestito: article) {
      closet.removeAll { $0.id == vestito.id }
      salvaArmadio()
  }
  
 func readArmadio(fileName: String) -> [article]? {
      if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
          let fileURL = documentDirectory.appendingPathComponent(fileName)
          do {
              let data = try Data(contentsOf: fileURL)
              let decoder = JSONDecoder()
              let closet = try decoder.decode([article].self, from: data)
              return closet
          } catch {
              print("Failed to read JSON data: \(error.localizedDescription)")
          }
      }
      return nil
  }
  
  func salvaArmadio() {
      do {
          let encoder = JSONEncoder()
          encoder.outputFormatting = .prettyPrinted
          
          let jsonData = try encoder.encode(closet)
          
          if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
              let fileURL = documentDirectory.appendingPathComponent("armadio.json")
              try jsonData.write(to: fileURL)
              print("File JSON scritto con successo a: \(fileURL)")
          }
      } catch {
          print("Errore durante la scrittura del file JSON: \(error.localizedDescription)")
      }
  }



