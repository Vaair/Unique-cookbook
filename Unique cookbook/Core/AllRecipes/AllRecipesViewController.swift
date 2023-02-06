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

class AllRecipesViewController: UIViewController {
    var presenter: AllRecipesPresenterProtocol!
    
    private var collectionView: AllRecipesCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        arrangeCollectionView()
        setupNewRecipeBarButtonItem()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.snp.updateConstraints { make in
            make.leading.trailing.equalToSuperview().inset(
                GlobalVariables.isPortrait ?
                Constants.leadingTrailingInsetCollectionViewPortrait :
                    Constants.leadingTrailingInsetCollectionView
            )
        }
    }
    
    private func setupView() {
        view.backgroundColor = .CustomColors.background
        title = Localization.title
    }
    
    private func arrangeCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(
                GlobalVariables.isPortrait ?
                Constants.leadingTrailingInsetCollectionViewPortrait :
                    Constants.leadingTrailingInsetCollectionView
            )
        }
    }

    func setCollectionView(collectionView: AllRecipesCollectionView) {
        self.collectionView = collectionView
        collectionView.configure()
    }
    
    private func setupNewRecipeBarButtonItem() {
        let newRecipeBarButton = UIButton(type: .system)
        newRecipeBarButton.setImage(
            Constants.newRecipeBarButtonItemImage,
            for: .normal
        )
        newRecipeBarButton.setTitle(
            Localization.newRecipeBarButtonItemTitle,
            for: .normal
        )
        newRecipeBarButton.titleEdgeInsets = UIEdgeInsets(
            top: .zero,
            left: .zero,
            bottom: .zero,
            right: -Constants.newRecipeBarButtonItemImageInset
        )
        newRecipeBarButton.sizeToFit()
        newRecipeBarButton.addTarget(self, action: #selector(newRecipeAction), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: newRecipeBarButton)
    }
    
    @objc func newRecipeAction() {
        presenter.newRecipeAction()
    }
}

extension AllRecipesViewController: AllRecipesViewProtocol {
    
}

extension AllRecipesViewController {
    enum Constants {
        static let leadingTrailingInsetCollectionViewPortrait = GlobalVariables.screenWidth.getValue(with: 5)
        static let leadingTrailingInsetCollectionView = GlobalVariables.screenHeight.getValue(with: 6)
        static let newRecipeBarButtonItemImage = UIImage(systemName: "plus.circle.fill")
        static let newRecipeBarButtonItemImageInset = GlobalVariables.screenWidth.getValue(with: 1)
    }
    
    enum Localization {
        static let title = "all_recipe_title".localized
        static let newRecipeBarButtonItemTitle =  "all_recipe_new_recipe_button_title".localized
    }
}

