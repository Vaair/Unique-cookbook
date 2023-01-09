//
//  MainPresenter.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 09.01.2023.
//

import Foundation

protocol MainPresenterProtocol {

}

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var router: RouterProtocol?

    
    
    required init(view: MainViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
}
