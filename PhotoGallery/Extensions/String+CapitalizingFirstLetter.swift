//
//  String+CapitalizingFirstLetter.swift
//  PhotoGallery
//
//  Created by Eduard Galchenko on 07.11.2020.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
