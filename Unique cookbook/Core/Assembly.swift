//
//  Assembly.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 09.01.2023.
//

import UIKit

protocol AssemblyProtocol {
    func createMainModule(router: RouterProtocol) -> UITabBarController
}

class Assembly: AssemblyProtocol {
    func createMainModule(router: RouterProtocol) -> UITabBarController {
        let allRecipesVC = AllRecipesViewController()
        let favoritesVC = FavoritesViewController()
        let searchVC = SearchViewController()
        let view = MainViewController(
            allRecipesVC: allRecipesVC,
            favoritesVC: favoritesVC,
            searchVC: searchVC
        )
        let presenter = MainPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}
