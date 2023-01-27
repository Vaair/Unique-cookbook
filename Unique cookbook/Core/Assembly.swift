//
//  Assembly.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 09.01.2023.
//

import UIKit

protocol AssemblyProtocol {
    func createMainModule(router: RouterProtocol) -> UITabBarController
    func createAllRecipesCollectionView() -> AllRecipesCollectionView
}

class Assembly: AssemblyProtocol {
    func createMainModule(router: RouterProtocol) -> UITabBarController {
        let allRecipesVC = AllRecipesViewController()
        let allRecipesPresenter = AllRecipesPresenter(view: allRecipesVC)
        allRecipesVC.presenter = allRecipesPresenter
        allRecipesVC.setCollectionView(collectionView: createAllRecipesCollectionView())
        let allRecipesNavVC = UINavigationController(rootViewController: allRecipesVC)
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let view = MainViewController(
            allRecipesVC: allRecipesNavVC,
            favoritesVC: favoritesVC,
            searchVC: searchVC
        )
        let presenter = MainPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createAllRecipesCollectionView() -> AllRecipesCollectionView {
        let allRecipesCollectionView = AllRecipesCollectionView()
        let presenter = AllRecipesCollectionViewPresenter(view: allRecipesCollectionView)
        allRecipesCollectionView.presenter = presenter
        return allRecipesCollectionView
    }
}
