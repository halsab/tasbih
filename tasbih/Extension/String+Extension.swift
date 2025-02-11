//
//  String+Extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 11.02.2025.
//

import Foundation

extension String {
    var withoutWhitespaces: String {
        filter { !$0.isWhitespace }
    }
    
    var isEmptyCompletely: Bool {
        withoutWhitespaces.isEmpty
    }
    
    /// Compare lowercased without witespaces
    func like(string: String) -> Bool {
        self.withoutWhitespaces.lowercased() == string.withoutWhitespaces.lowercased()
    }
}
