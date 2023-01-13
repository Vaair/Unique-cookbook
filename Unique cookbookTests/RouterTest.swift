//
//  RouterTest.swift
//  Unique cookbookTests
//
//  Created by Лера Тарасенко on 13.01.2023.
//

import XCTest
@testable import Unique_cookbook

class MockNavigationController: UINavigationController {
    var presentesVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        self.presentesVC = viewController
    }
}

final class RouterTest: XCTestCase {
    var router: RouterProtocol!
    var navigationController = MockNavigationController()
    let assembly = Assembly()

    override func setUpWithError() throws {
        router = Router(navigationController: navigationController, assembly: assembly)
    }

    override func tearDownWithError() throws {
        router = nil
    }
    
    func testRouter() {
        router.initialViewController()
        let mainVC = navigationController.viewControllers.first
        XCTAssertTrue(mainVC is MainViewController)
    }

}
