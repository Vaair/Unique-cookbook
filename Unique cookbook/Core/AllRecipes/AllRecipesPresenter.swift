//
//  AllRecipesPresenter.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 20.01.2023.
//

import Foundation

protocol AllRecipesPresenterProtocol {
    func newRecipeAction()
}

class AllRecipesPresenter: AllRecipesPresenterProtocol {
    weak var view: AllRecipesViewProtocol?
    
    required init(view: AllRecipesViewProtocol) {
        self.view = view
    }
    
    func newRecipeAction() {
        
    }
}
