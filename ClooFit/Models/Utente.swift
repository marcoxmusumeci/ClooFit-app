//
//  Utente.swift
//  ClooFit
//
//  Created by Oteri Salvatore on 05/07/24.
//

import Foundation
var user: UserAttributes = readJSONFILE(fileName: "ddt.json") ?? UserAttributes(age: "18", gender: "Male", eyeColor: "Brown", hairColor: "Brown", skinColor: "1", stagione: 3, isTest: false)
  

struct UserAttributes: Codable {
    var age: String?
    var gender: String?
    var eyeColor: String?
    var hairColor: String?
    var skinColor: String?
    var stagione: Int?
    var isTest: Bool

    enum CodingKeys: String, CodingKey {
        case age = "selectedAge"
        case gender = "selectedGender"
        case eyeColor = "selectedEyeColor"
        case hairColor = "selectedHairColor"
        case skinColor = "selectedSkinColor"
        case stagione = "selectedStagione"
        case isTest = "selectedisTest"
    }
}




func loadUserAttributes(from fileName: String) -> UserAttributes? {
    let decoder = JSONDecoder()

    guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        print("Failed to access document directory.")
        return nil
    }

    let fileURL = documentDirectory.appendingPathComponent("ddt.json")

    // Check if the file exists
    if !FileManager.default.fileExists(atPath: fileURL.path) {
        print("File not found at: \(fileURL.path)")
        return nil
    }

    do {
        let data = try Data(contentsOf: fileURL)
        let decodedAttributes = try decoder.decode(UserAttributes.self, from: data)
        return decodedAttributes
    } catch {
        print("Failed to decode \(fileName).json: \(error.localizedDescription)")
        return nil
    }
}



