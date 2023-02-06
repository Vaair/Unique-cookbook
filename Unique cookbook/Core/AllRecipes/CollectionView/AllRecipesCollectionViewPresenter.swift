//
//  AllRecipesCollectionViewPresenter.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 20.01.2023.
//
#warning("вернуть foundation")
import UIKit

protocol AllRecipesCollectionViewPresenterProtocol {
    func getSections() -> [AllRecipesCollectionSectionModel]
    func getSectionType(from section: Int) -> AllRecipesCollectionSectionModel.SectionType?
    func getPresenter(
        from section: Int,
        itemNumber: Int,
        view: CollectionViewCellProtocol
    ) -> CollectionViewCellPresenter?
}

class AllRecipesCollectionViewPresenter: AllRecipesCollectionViewPresenterProtocol {
    weak var view: AllRecipesCollectionViewProtocol?
    
    private var sections: [AllRecipesCollectionSectionModel] = [
        AllRecipesCollectionSectionModel(
            type: .recently,
            title: "Test da",
            items: [
            AllRecipesCollectionCellModel(id: "1", title: "test1", image: UIImage(), status: 0),
            AllRecipesCollectionCellModel(id: "2", title: "test2", image: UIImage(), status: 1),
            AllRecipesCollectionCellModel(id: "3", title: "test3", image: UIImage(), status: 2),
            AllRecipesCollectionCellModel(id: "4", title: "test4", image: UIImage(), status: 0),
            AllRecipesCollectionCellModel(id: "5", title: "test5 test5 test5 test5 test5 test5", image: UIImage(), status: 0),
            AllRecipesCollectionCellModel(id: "6", title: "test6", image: UIImage(), status: 0),
        ]),
        AllRecipesCollectionSectionModel(type: .all,
                                         items: [
            AllRecipesCollectionCellModel(id: "7", title: "test1 test1 test1 test1 test1 test1 test1 test1 test1 test1 test1 test1 test1 test1 test1", image: UIImage(), status: 0),
            AllRecipesCollectionCellModel(id: "8", title: "test2", image: UIImage(), status: 1),
            AllRecipesCollectionCellModel(id: "9", title: "test3", image: UIImage(), status: 2),
            AllRecipesCollectionCellModel(id: "10", title: "test4", image: UIImage(), status: 0),
            AllRecipesCollectionCellModel(id: "11", title: "test5", image: UIImage(), status: 0),
            AllRecipesCollectionCellModel(id: "12", title: "test6", image: UIImage(), status: 0),
            AllRecipesCollectionCellModel(id: "13", title: "test11", image: UIImage(), status: 0),
            AllRecipesCollectionCellModel(id: "14", title: "test21", image: UIImage(), status: 0),
            AllRecipesCollectionCellModel(id: "15", title: "test31", image: UIImage(), status: 0),
            AllRecipesCollectionCellModel(id: "16", title: "test41", image: UIImage(), status: 0),
            AllRecipesCollectionCellModel(id: "17", title: "test51", image: UIImage(), status: 0),
            AllRecipesCollectionCellModel(id: "18", title: "test61", image: UIImage(), status: 0),
        ]),
        ]
    
    func getSections() -> [AllRecipesCollectionSectionModel] {
        return sections
    }
    
    func getSectionType(from section: Int) -> AllRecipesCollectionSectionModel.SectionType? {
        return sections[safe: section]?.type
    }
    
    func getPresenter(
        from section: Int,
        itemNumber: Int,
        view: CollectionViewCellProtocol
    ) -> CollectionViewCellPresenter? {
        guard let item = sections[safe: section]?.items[safe: itemNumber] else { return nil }
        return CollectionViewCellPresenter(view: view, model: item)
    }
    
    required init(view: AllRecipesCollectionViewProtocol) {
        self.view = view
    }
}
