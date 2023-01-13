//
//  MainPresenterTest.swift
//  Unique cookbookTests
//
//  Created by Лера Тарасенко on 29.09.2022.
//

import XCTest
@testable import Unique_cookbook

class MockView: MainViewProtocol{
    func success() {
        
    }
    
    func failure(error: Error) {
        
    }
    
   
}

class MainPresenterTest: XCTestCase {
    
    var mockView: MockView!
    var presenter: MainPresenter!
    var router: RouterProtocol!

    override func setUpWithError() throws {
        let nav = UINavigationController()
        let assembly = Assembly()
        router = Router(navigationController: nav, assembly: assembly)
    }

    override func tearDownWithError() throws {
        mockView = nil
        presenter = nil
    }

}
