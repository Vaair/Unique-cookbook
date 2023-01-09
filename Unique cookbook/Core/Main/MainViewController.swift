//
//  MainViewController.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 29.09.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {

}

class MainViewController: UITabBarController {
    var presenter: MainPresenterProtocol!



    init(
        allRecipesVC: AllRecipesViewController,
        favoritesVC: FavoritesViewController,
        searchVC: SearchViewController
    ) {
        allRecipesVC.tabBarItem = TabBarItem.allRecipes.getTabBarItem()
        favoritesVC.tabBarItem = TabBarItem.favorites.getTabBarItem()
        searchVC.tabBarItem = TabBarItem.search.getTabBarItem()
        super.init(nibName: nil, bundle: nil)
        viewControllers = [allRecipesVC, favoritesVC, searchVC]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension MainViewController: MainViewProtocol {
}

extension MainViewController {
    enum Localization {
        static let allRecipesTabBarItemTitle = "Все рецепты"
        static let favoritesTabBarItemTitle = "Избранное"
        static let searchTabBarItemTitle = "Поиск"
    }

    enum Constants {
        static let allRecipesImage = UIImage(systemName: "tray.full.fill")
        static let favoritesImage = UIImage(systemName: "star.fill")
        static let searchImage = UIImage(systemName: "magnifyingglass")
        static let allRecipesTag = 0
        static let favoritesTag = 1
        static let searchTag = 2
    }

    enum TabBarItem {
        case allRecipes
        case favorites
        case search

        func getTitle() -> String {
            switch self {
            case .allRecipes:
                return Localization.allRecipesTabBarItemTitle
            case .favorites:
                return Localization.favoritesTabBarItemTitle
            case .search:
                return Localization.searchTabBarItemTitle
            }
        }

        func getImage() -> UIImage? {
            switch self {
            case .allRecipes:
                return Constants.allRecipesImage
            case .favorites:
                return Constants.favoritesImage
            case .search:
                return Constants.searchImage
            }
        }

        func getTag() -> Int {
            switch self {
            case .allRecipes:
                return Constants.allRecipesTag
            case .favorites:
                return Constants.favoritesTag
            case .search:
                return Constants.searchTag
            }
        }

        func getTabBarItem() -> UITabBarItem {
            return UITabBarItem(
                title: getTitle(),
                image: getImage(),
                tag: getTag()
            )
        }

    }
}
