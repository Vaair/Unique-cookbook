//
//  AllRecipesCollectionView.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 20.01.2023.
//

import UIKit
import SnapKit

protocol AllRecipesCollectionViewProtocol: AnyObject {

}

class AllRecipesCollectionView: UICollectionView, AllRecipesCollectionViewProtocol {
    var presenter: AllRecipesCollectionViewPresenterProtocol!
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<AllRecipesCollectionSectionModel, AllRecipesCollectionCellModel>?
    
    init() {
        super.init(frame: .zero, collectionViewLayout: .init())
        
        delegate = self
        
        register(
            AllRecipesCollectionViewCell.self,
            forCellWithReuseIdentifier: AllRecipesCollectionViewCell.Constants.reuseId
        )
        register(
            RecentlyCollectionViewCell.self,
            forCellWithReuseIdentifier: RecentlyCollectionViewCell.Constants.reuseId
        )
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        collectionViewLayout = createCompositionalLayout()
        createDataSource()
        addSections()
    }
    
    private func createDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource<AllRecipesCollectionSectionModel, AllRecipesCollectionCellModel>(
            collectionView: self,
             cellProvider: { [weak self] (collectionView, indexPath, _) -> UICollectionViewCell? in
                 guard let self = self else { return nil }
                 let type = self.presenter.getSectionType(from: indexPath.section)
                 
                 switch type {
                 case .recently:
                     let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: RecentlyCollectionViewCell.Constants.reuseId,
                        for: indexPath
                     ) as? RecentlyCollectionViewCell
                     let item = self.presenter.getItem(from: indexPath.section, itemNumber: indexPath.item)
                     cell?.presenter = AllCollectionViewCellPresenter(model: item)
                     cell?.configure()
                     return cell
                 case .all:
                     let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: AllRecipesCollectionViewCell.Constants.reuseId,
                        for: indexPath
                     ) as? AllRecipesCollectionViewCell
                     let item = self.presenter.getItem(from: indexPath.section, itemNumber: indexPath.item)
                     cell?.presenter = AllCollectionViewCellPresenter(model: item)
                     cell?.configure()
                     return cell
                 }
            })
        
    }
    
    private func addSections() {
        var snapshot = NSDiffableDataSourceSnapshot<AllRecipesCollectionSectionModel, AllRecipesCollectionCellModel>()
        let sections = presenter.getSections()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        diffableDataSource?.apply(snapshot)
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) in
            guard let self = self else { return nil }
            let type = self.presenter.getSectionType(from: sectionIndex)
            
            switch type {
            case .recently:
                return self.createRecentlySection()
            case .all:
                return self.createAllRecipesSection()
            }
        }
        return layout
    }
    
    private func createRecentlySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.widthDimensionRecentlyItem),
            heightDimension: .fractionalHeight(Constants.heightDimensionRecentlyItem)
        )
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(
            top: .zero,
            leading: Constants.insetRecentlyItem,
            bottom: .zero,
            trailing: Constants.insetRecentlyItem
        )
        
        let layoutGroupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(Constants.widthDimensionRecentlyGroup),
            heightDimension: .estimated(Constants.heightDimensionRecentlyGroup)
        )
        let layoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: layoutGroupSize,
            subitems: [layoutItem]
        )
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(
            top: .zero,
            leading: Constants.insetRecentlySection,
            bottom: .zero,
            trailing: Constants.insetRecentlySection
        )
        
        return layoutSection
    }
    
    private func createAllRecipesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(86))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 66, leading: 20, bottom: 0, trailing: 20)
        return section
    }
}

// MARK: - UICollectionViewDelegate
extension AllRecipesCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension AllRecipesCollectionView {
    enum Constants {
        static let widthDimensionRecentlyItem: CGFloat = 1
        static let heightDimensionRecentlyItem: CGFloat = 1
        static let insetRecentlyItem: CGFloat = GlobalConstants.screenWidth.getValue(with: 2)
        static let widthDimensionRecentlyGroup: CGFloat = GlobalConstants.screenWidth.getValue(with: 40)
        static let heightDimensionRecentlyGroup: CGFloat = GlobalConstants.screenWidth.getValue(with: 40)
        static let insetRecentlySection: CGFloat = GlobalConstants.screenWidth.getValue(with: 3)
    }
}
