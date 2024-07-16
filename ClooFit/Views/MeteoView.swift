//
//  MeteoView.swift
//  ClooFit
//
//  Created by Paolo Sortino on 10/07/24.
//

//
//  getMeteoInfo.swift
//  ClooFit
//
//  Created by Paolo Sortino on 10/07/24.
//

import Foundation
import OpenMeteoSdk
import SwiftUI
import Combine

struct Weather: Codable {
    let current_weather: CurrentWeather
}

struct CurrentWeather: Codable {
    let temperature: Double
    let weathercode: Int
}

struct WMOWeatherCode {
    let code: Int
    let description: String
    
    static func description(for code: Int) -> String {
        switch code {
        case 0:
            return "Clear sky"
        case 1, 2, 3:
            return "Mainly clear, partly cloudy, and overcast"
        case 45, 48:
            return "Fog and depositing rime fog"
        case 51, 53, 55:
            return "Drizzle: Light, moderate, and dense intensity"
        case 56, 57:
            return "Freezing Drizzle: Light and dense intensity"
        case 61, 63, 65:
            return "Rain: Slight, moderate and heavy intensity"
        case 66, 67:
            return "Freezing Rain: Light and heavy intensity"
        case 71, 73, 75:
            return "Snow fall: Slight, moderate, and heavy intensity"
        case 77:
            return "Snow grains"
        case 80, 81, 82:
            return "Rain showers: Slight, moderate, and violent"
        case 85, 86:
            return "Snow showers slight and heavy"
        case 95:
            return "Thunderstorm: Slight or moderate"
        case 96, 99:
            return "Thunderstorm with slight and heavy hail"
        default:
            return "Unknown weather code"
        }
    }
}

struct WeatherImageProvider {
    static func imageName(for code: Int) -> Image {
        switch code {
        case 0...4:
            return Image(systemName: "sun.max") // Image for sunny weather
        case 45...48:
            return Image(systemName: "cloud.fog") // Image for foggy weather
        case 51...67:
            return Image(systemName: "cloud.rain") // Image for rainy weather
        case 71...77:
            return Image(systemName: "cloud.snow") // Image for snowy weather
        case 80...99:
            return Image(systemName: "cloud.bolt") // Image for stormy weather
        default:
            return Image(systemName: "cloud") // Default image for unknown weather
        }
    }
}

func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (Weather?) -> Void) {
    let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true"
    guard let url = URL(string: urlString) else {
        completion(nil)
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error fetching weather: \(error.localizedDescription)")
            completion(nil)
            return
        }
        
        guard let data = data else {
            print("No data returned")
            completion(nil)
            return
        }
        
        do {
            let weatherResponse = try JSONDecoder().decode(Weather.self, from: data)
            DispatchQueue.main.async {
                completion(weatherResponse)
            }
        } catch {
            print("Error decoding weather data: \(error.localizedDescription)")
            completion(nil)
        }
    }.resume()
}

struct MeteoView: View {
    @StateObject var locationManager = CurrentPosition()
        @State private var weather: Weather?
        
        var body: some View {
            VStack {
                if let city = locationManager.city {
                    // Text("Città: \(city)")
                    if let weather = weather {
                        // Text("Temperatura: \(weather.current_weather.temperature)°C")
                        // Text("Weather code: \(weather.current_weather.weathercode)")
                        HStack {
                            WeatherImageProvider.imageName(for: weather.current_weather.weathercode)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 30, height: 30)
                            Spacer().frame(width: 15)
                            Text("\(WMOWeatherCode.description(for: weather.current_weather.weathercode))")
                        }
                    } else {
                        Text("Caricamento meteo...")
                            .onAppear {
                                if let location = locationManager.location {
                                    fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { weather in
                                        self.weather = weather
                                    }
                                }
                            }
                    }
                } else {
                    Text("Ottenendo la tua posizione...")
                }
            }
            .onAppear {
                // Se la posizione è già disponibile, carica il meteo
                if let location = locationManager.location {
                    fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { weather in
                        self.weather = weather
                    }
                }
            }
        }
}

#Preview {
    // ItemListView(filteredList: closet)
    // CategoryView(typeName: "pants")
    // ClosetView()
    MeteoView()
}
