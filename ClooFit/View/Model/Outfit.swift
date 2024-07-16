//
//  Outfit.swift
//  ClooFit
//
//  Created by Claudio Sottile on 04/07/24.
//

import Foundation
import SwiftUI

struct Outfit {
    var upper: Article
    var lower: Article
    
    init(upper: Article, lower: Article) {
        self.upper = upper
        self.lower = lower
    }
}
