//
//  AllRecipesCollectionSectionType.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 20.01.2023.
//

import Foundation

struct AllRecipesCollectionSectionModel: Hashable {
    var type: SectionType
    var title: String?
    var items: [AllRecipesCollectionCellModel]
    
    enum SectionType {
        case recently
        case all
    }
}
