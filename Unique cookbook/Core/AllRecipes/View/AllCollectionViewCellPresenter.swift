//
//  AllCollectionViewCellPresenter.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 22.01.2023.
//

#warning("вернуть foundation")
import UIKit

protocol AllCollectionViewCellPresenterProtocol {
    func getTitle() -> String
    func getImage() -> UIImage?
}

class AllCollectionViewCellPresenter: AllCollectionViewCellPresenterProtocol {
    private var model: AllRecipesCollectionCellModel
    
    init(model: AllRecipesCollectionCellModel) {
        self.model = model
    }
    
    func getTitle() -> String {
        model.title
    }
    
    func getImage() -> UIImage? {
        model.image
    }
}
