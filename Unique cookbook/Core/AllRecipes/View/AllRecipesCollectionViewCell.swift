//
//  AllRecipesCollectionViewCell.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 20.01.2023.
//

import UIKit

class AllRecipesCollectionViewCell: UICollectionViewCell {
    var presenter: AllCollectionViewCellPresenterProtocol!
    
    func configure() {
        
    }
}

extension AllRecipesCollectionViewCell {
    enum Constants {
        static let reuseId = "AllRecipesCollectionViewCell"
    }
}
