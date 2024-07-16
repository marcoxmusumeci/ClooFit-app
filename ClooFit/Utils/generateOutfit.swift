//
//  generateOutfit.swift
//  ClooFit
//
//  Created by Oteri Salvatore on 09/07/24.
//

import Foundation

func generateOutfit(array:[article], weather: String, gender: String, elegance: String) -> Outfit{
    var upper: article
    var lower: article
    var subArray: [article] = weatherFilter(from: genderFilter(from: eleganceFilter(from: typeFilter(from: array, type: "top") ?? array , elegance: elegance) ?? array , gender: user.gender ?? "") ?? array , weather: weather) ?? array
    upper = subArray.randomElement() ?? catalogo[1]
     var subArrayLower = weatherFilter(from: genderFilter(from: eleganceFilter(from: typeFilter(from: array, type: "bottom") ?? array , elegance: elegance) ?? array , gender: gender) ?? array , weather: weather) ?? array
    var count = 0
    repeat{
        lower = subArrayLower.randomElement() ?? catalogo[44]
        count += 1
    }while(areColorsHarmonious(upper: upper, lower: lower) && count <= 50)
    
    return Outfit(upper: upper, lower: lower)
    
    
    
}

func getArticles(array: [Outfit], type: String) -> [article]{
    var ris: [article] = []
    if(type == "top"){
        for fit in array{
            ris.append(fit.upper)
        }
    }else{
        for fit in array{
            ris.append(fit.lower)
        }
    }
    return ris
}

/*notDefaultFilter(array: [Outfit]) -> [Outfit]{
    
}*/
