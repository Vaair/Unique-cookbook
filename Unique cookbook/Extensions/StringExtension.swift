//
//  StringExtension.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 13.01.2023.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(
            self,
            tableName: nil,
            bundle: Bundle.localizedBundle(),
            value: "",
            comment: ""
        )
    }
}
