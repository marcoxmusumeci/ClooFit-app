//
//  articolo.swift
//  ClooFit
//
//  Created by Oteri Salvatore on 05/07/24.
//

import Foundation
import SwiftUI

struct colorRGB: Codable {
    var r: Double
    var g: Double
    var b: Double
    
    var norm_r: Double{
        r/255
    }
    
    var norm_g: Double{
        g/255
    }
    
    var norm_b: Double{
        b/255
    }
    
    var h: Double{
        let max = Swift.max(norm_r, norm_g, norm_b)
        let min = Swift.min(norm_r, norm_g, norm_b)
        let delta = max - min
        
        var ris: Double = 0
        if delta != 0{
            if max == r {
                ris = (g - b) / delta + (g < b ? 6 : 0)
            } else if max == g {
                        ris = (b - r) / delta + 2
            } else {
                ris = (r - g) / delta + 4
            }
            ris /= 6
        }
        
        
        
        return ris * 360
    }
    
    var s: Double{
        let max = Swift.max(norm_r, norm_g, norm_b)
        let min = Swift.min(norm_r, norm_g, norm_b)
        let delta = max - min
        
        var ris: Double = 0
        
        if delta != 0{
            ris = l > 0.5 ? delta / (2.0 - max - min) : delta / (max + min)
        }
        
        return ris
    }
    
    var l: Double{
        let max = Swift.max(norm_r, norm_g, norm_b)
        let min = Swift.min(norm_r, norm_g, norm_b)
        let delta = max - min
        
        
        return (max + min) / 2
    }
}

struct article: Codable, Identifiable {
    var id: String
    var gender: String
    var name: String
    var material: String
    var mainColor: String
    var mainColorRGB: colorRGB
    var type: String
    var elegance: String
    var weather: String
    
    var image: Image {
        Image(id)
    }
    
   
}

struct articleID: Codable, Identifiable {
    var id: String
}

/*
 "id": "SO01",
 "gender": "unisex",
 "name": "t-shirt",
 "material": "cotton",
 "mainColor": "black",
 "mainColorRGB" : {
     "r" : 0,
     "g" : 0,
     "b" : 0
 },
 "type" : "top",
 "elegance" : "informal",
 "weather" : "hot"
 */

