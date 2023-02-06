//
//  GlobalConstants.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 22.01.2023.
//

import UIKit

struct GlobalVariables {
    static var screenWidth: CGFloat { isPortrait ?
        UIScreen.main.bounds.width :
        UIScreen.main.bounds.height
    }
    static var screenHeight: CGFloat { isPortrait ?
        UIScreen.main.bounds.height :
        UIScreen.main.bounds.width
    }
    static let isiPad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    static var isPortrait: Bool {
        UIDevice.current.orientation == .portrait ||
        UIDevice.current.orientation == .portraitUpsideDown ||
        UIDevice.current.orientation == .faceUp
    }
}
