//
//  Router.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 09.01.2023.
//

import UIKit

protocol RouterMainProtocol {
    var navigationController: UINavigationController { get set }
    var assembly: AssemblyProtocol { get set }
}

protocol RouterProtocol: RouterMainProtocol {
    func initialViewController()
    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController
    var assembly: AssemblyProtocol

    init(navigationController: UINavigationController, assembly: AssemblyProtocol) {
        self.navigationController = navigationController
        self.assembly = assembly
    }

    func initialViewController() {
        let vc = assembly.createMainModule(router: self)
        navigationController.viewControllers = [vc]
    }

    func popToRoot() {
        navigationController.popViewController(animated: true)
    }
}
