//
//  CollectionViewCellPresenter.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 22.01.2023.
//

#warning("вернуть foundation")
import UIKit

protocol CollectionViewCellPresenterProtocol {
    func getTitle() -> String
    func getImage() -> UIImage?
    func getStatus() -> Int
}

class CollectionViewCellPresenter: CollectionViewCellPresenterProtocol {
    weak var view: CollectionViewCellProtocol?
    private var model: AllRecipesCollectionCellModel
    
    init(view: CollectionViewCellProtocol, model: AllRecipesCollectionCellModel) {
        self.view = view
        self.model = model
    }
    
    func getTitle() -> String {
        model.title
    }
    
    func getImage() -> UIImage? {
        model.image
    }
    
    func getStatus() -> Int {
        model.status
    }
    
    
}
