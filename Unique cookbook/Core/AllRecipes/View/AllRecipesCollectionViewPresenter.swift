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
    func getSectionType(from section: Int) -> AllRecipesCollectionSectionModel.SectionType
    func getItem(from section: Int, itemNumber: Int) -> AllRecipesCollectionCellModel
}

class AllRecipesCollectionViewPresenter: AllRecipesCollectionViewPresenterProtocol {
    weak var view: AllRecipesCollectionViewProtocol?
    
    private var sections: [AllRecipesCollectionSectionModel] = [
        AllRecipesCollectionSectionModel(type: .recently, items: [
            AllRecipesCollectionCellModel(id: "1", title: "test1", image: UIImage()),
            AllRecipesCollectionCellModel(id: "2", title: "test2", image: UIImage()),
            AllRecipesCollectionCellModel(id: "3", title: "test3", image: UIImage()),
            AllRecipesCollectionCellModel(id: "4", title: "test4", image: UIImage()),
            AllRecipesCollectionCellModel(id: "5", title: "test5 test5 test5 test5 test5 test5", image: UIImage()),
            AllRecipesCollectionCellModel(id: "6", title: "test6", image: UIImage()),
        ]),
        AllRecipesCollectionSectionModel(type: .all, items: [
            AllRecipesCollectionCellModel(id: "7", title: "test1", image: UIImage()),
            AllRecipesCollectionCellModel(id: "8", title: "test2", image: UIImage()),
            AllRecipesCollectionCellModel(id: "9", title: "test3", image: UIImage()),
            AllRecipesCollectionCellModel(id: "10", title: "test4", image: UIImage()),
            AllRecipesCollectionCellModel(id: "11", title: "test5", image: UIImage()),
            AllRecipesCollectionCellModel(id: "12", title: "test6", image: UIImage()),
            AllRecipesCollectionCellModel(id: "13", title: "test11", image: UIImage()),
            AllRecipesCollectionCellModel(id: "14", title: "test21", image: UIImage()),
            AllRecipesCollectionCellModel(id: "15", title: "test31", image: UIImage()),
            AllRecipesCollectionCellModel(id: "16", title: "test41", image: UIImage()),
            AllRecipesCollectionCellModel(id: "17", title: "test51", image: UIImage()),
            AllRecipesCollectionCellModel(id: "18", title: "test61", image: UIImage()),
        ]),
        ]
    
    func getSections() -> [AllRecipesCollectionSectionModel] {
        return sections
    }
    
    func getSectionType(from section: Int) -> AllRecipesCollectionSectionModel.SectionType {
        return sections[section].type
    }
    
    func getItem(from section: Int, itemNumber: Int) -> AllRecipesCollectionCellModel {
        return sections[section].items[itemNumber]
    }
    
    required init(view: AllRecipesCollectionViewProtocol) {
        self.view = view
    }
}

