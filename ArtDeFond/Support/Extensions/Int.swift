//
//  Int.swift
//  ArtDeFond
//
//  Created by Someone on 24.08.2022.
//

import Foundation

extension Int {
    func toRubles() -> String {
        let stringDouble = String(format: "%.0f", Double(self)/100)
        return "₽\(stringDouble)"
    }
}
