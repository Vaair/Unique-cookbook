//
//  ArrayExtension.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 02.02.2023.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
