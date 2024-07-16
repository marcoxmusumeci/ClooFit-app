//
//  Article.swift
//  ClooFit
//
//  Created by Claudio Sottile on 04/07/24.
//

import Foundation
import SwiftUI

struct Article {
    var id: Int
    var path: String
    var red: Double
    var redNormalized: Double
    var green: Double
    var greenNormalized: Double
    var blue: Double
    var blueNormalized: Double
    var colorLabel: String
    var image: Image {
        Image(path)
    }
    
    init(id: Int, path: String, red: Double, green: Double, blue: Double, colorLabel: String) {
        self.id = id
        self.path = path
        self.red = red
        self.redNormalized = red / 255
        self.green = green
        self.greenNormalized = green / 255
        self.blue = blue
        self.blueNormalized = blue / 255
        self.colorLabel = colorLabel
    }
}
