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

class AllRecipesCollectionView: UICollectionView {
    var presenter: AllRecipesCollectionViewPresenterProtocol!
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<AllRecipesCollectionSectionModel, AllRecipesCollectionCellModel>?
    
    init() {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.headerMode = .supplementary
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        super.init(frame: .zero, collectionViewLayout: listLayout)
        
        delegate = self
        
        register(
            AllRecipesCollectionViewCell.self,
            forCellWithReuseIdentifier: AllRecipesCollectionViewCell.reuseIdentifier
        )
        register(
            RecentlyCollectionViewCell.self,
            forCellWithReuseIdentifier: RecentlyCollectionViewCell.reuseIdentifier
        )
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        showsVerticalScrollIndicator = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        collectionViewLayout = createCompositionalLayout()
        collectionViewLayout.register(
            RoundedBackgroundView.self,
            forDecorationViewOfKind: RoundedBackgroundView.reuseIdentifier
        )
        createDataSource()
        addSections()
        setupHeader()
    }
    
    private func createDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource<AllRecipesCollectionSectionModel, AllRecipesCollectionCellModel>(
            collectionView: self,
            cellProvider: { [unowned self] (collectionView, indexPath, _) -> UICollectionViewCell? in
                guard let type = self.presenter.getSectionType(from: indexPath.section) else { return nil }
                
                switch type {
                case .recently:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: RecentlyCollectionViewCell.reuseIdentifier,
                        for: indexPath
                    ) as? RecentlyCollectionViewCell else { return nil }
                    cell.presenter = self.presenter.getPresenter(
                        from: indexPath.section,
                        itemNumber: indexPath.item,
                        view: cell
                    )
                    cell.configure()
                    return cell
                case .all:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: AllRecipesCollectionViewCell.reuseIdentifier,
                        for: indexPath
                    ) as? AllRecipesCollectionViewCell else { return nil }
                    cell.presenter = self.presenter.getPresenter(
                        from: indexPath.section,
                        itemNumber: indexPath.item,
                        view: cell
                    )
                    cell.configure()
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
    
    private func setupHeader() {
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { [unowned self] (headerView, elementKind, indexPath) in
            let headerItem = self.diffableDataSource?.snapshot().sectionIdentifiers[safe: indexPath.section]
            
            headerView.contentConfiguration = configHeader(headerView, headerItem: headerItem)
        }
        
        diffableDataSource?.supplementaryViewProvider = { [unowned self] (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            
            if elementKind == UICollectionView.elementKindSectionHeader {
                return self.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            } else {
                return nil
            }
        }
    }
    
    private func configHeader(
        _ headerView: UICollectionViewListCell,
        headerItem: AllRecipesCollectionSectionModel?
    ) -> UIListContentConfiguration {
        var configuration = headerView.defaultContentConfiguration()
        configuration.text = headerItem?.title

        configuration.textProperties.font = .CustomFont.recentrlyHeader
        configuration.textProperties.color = .label
        configuration.directionalLayoutMargins = .init(
            top: Constants.topHeaderMargin,
            leading: .zero,
            bottom: Constants.bottomHeaderMargin,
            trailing: .zero
        )
        
        return configuration
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [unowned self] (sectionIndex, layoutEnvironment) in
            guard let type = self.presenter.getSectionType(from: sectionIndex) else { return nil }
            
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
            leading: Constants.insetRecentlyItem,
            bottom: .zero,
            trailing: Constants.insetRecentlyItem
        )
        layoutSection.decorationItems = [
            NSCollectionLayoutDecorationItem.background(elementKind: RoundedBackgroundView.reuseIdentifier)
        ]
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(Constants.heightHeader)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        layoutSection.boundarySupplementaryItems = [header]
        
        return layoutSection
    }
    
    private func createAllRecipesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(Constants.heightAllItem)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(
            top: .zero,
            leading: .zero,
            bottom: Constants.insetBottomAllItem,
            trailing: .zero
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(1)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets.init(
            top: Constants.insetTopBottomAll,
            leading: Constants.insetTrailingLeadingAll,
            bottom: Constants.insetTopBottomAll,
            trailing: Constants.insetTrailingLeadingAll
        )
        section.decorationItems = [
            NSCollectionLayoutDecorationItem.background(elementKind: RoundedBackgroundView.reuseIdentifier)
        ]
        
        return section
    }
}

// MARK: - UICollectionViewDelegate
extension AllRecipesCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    
}

extension AllRecipesCollectionView: AllRecipesCollectionViewProtocol {
    
}

extension AllRecipesCollectionView {
    enum Constants {
        static let widthDimensionRecentlyItem: CGFloat = 1
        static let heightDimensionRecentlyItem: CGFloat = 0.6
        static let insetRecentlyItem: CGFloat = GlobalVariables.screenWidth.getValue(with: 2)
        static let widthDimensionRecentlyGroup: CGFloat = GlobalVariables.screenWidth.getValue(with: 40)
        static let heightDimensionRecentlyGroup: CGFloat = GlobalVariables.screenWidth.getValue(with: 70)
        static let insetRecentlySection: CGFloat = GlobalVariables.screenWidth.getValue(with: 3)
        static let topHeaderMargin = GlobalVariables.screenHeight.getValue(with: 2)
        static let bottomHeaderMargin = GlobalVariables.screenHeight.getValue(with: 1)
        static let heightHeader = GlobalVariables.screenHeight.getValue(with: 1)
        static let insetBottomAllItem = GlobalVariables.screenHeight.getValue(with: 1)
        static let insetTopBottomAll = insetTrailingLeadingAll + RoundedBackgroundView.Constants.topIndent
        static let insetTrailingLeadingAll = GlobalVariables.screenWidth.getValue(with: 4)
        static let heightAllItem = GlobalVariables.screenWidth.getValue(with: 25)
    }
}
