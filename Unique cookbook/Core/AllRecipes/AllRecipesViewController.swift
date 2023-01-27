//
//  AllRecipesViewController.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 09.01.2023.
//

import UIKit
import SnapKit

protocol AllRecipesViewProtocol: AnyObject {

}

class AllRecipesViewController: UIViewController, BaseViewControllerProtocol, AllRecipesViewProtocol {
    var presenter: AllRecipesPresenterProtocol!
    
    private var collectionView: AllRecipesCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        arrangeCollectionView()
    }
    
    func setupView() {
        view.backgroundColor = .CustomColors.background
        title = Localization.title
    }
    
    private func arrangeCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }

    func setCollectionView(collectionView: AllRecipesCollectionView) {
        self.collectionView = collectionView
        collectionView.configure()
    }

}

extension AllRecipesViewController {
    enum Constants {
        
    }
    
    enum Localization {
        static let title = "all_recipe_title".localized
    }
}

protocol BaseViewControllerProtocol {
    func setupView()
}
