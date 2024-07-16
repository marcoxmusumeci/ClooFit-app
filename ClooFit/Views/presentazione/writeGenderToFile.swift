import Foundation

func writeGenderToFile(gender: String) {
    let fileManager = FileManager.default
    let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
    if let documentDirectory = urls.first {
        let fileURL = documentDirectory.appendingPathComponent("stats.json")
        
        let data: [String: String] = ["gender": gender]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            try jsonData.write(to: fileURL, options: .atomic)
            print("Gender written to file successfully.")
        } catch {
            print("Failed to write gender to file: \(error.localizedDescription)")
        }
    }
}
