//
//  CGFloatExtension.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 22.01.2023.
//

import Foundation

extension CGFloat {
    func getValue(with percent: Float) -> CGFloat {
        let demical = CGFloat(percent / 100)
        return self * demical
    }
}
