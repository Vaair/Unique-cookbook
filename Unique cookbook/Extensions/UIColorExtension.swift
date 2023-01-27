//
//  UIColorExtension.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 09.01.2023.
//

import UIKit

extension UIColor {
    static func getThemeColor(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ? dark : light
            }
        } else {
            return light
        }
    }
    
    enum CustomColors {
        static var background: UIColor {
            getThemeColor(
                light: .white,
                dark: .black
            )
        }
//        #colorLiteral(red: 0.04665946215, green: 0.7452504635, blue: 0.05176623911, alpha: 1)
        static var green: UIColor {
            getThemeColor(
                light: #colorLiteral(red: 0.04665946215, green: 0.7452504635, blue: 0.05176623911, alpha: 1),
                dark: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            )
        }
        static var gray: UIColor {
            getThemeColor(
                light: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
                dark: #colorLiteral(red: 0.5357661843, green: 0.581982851, blue: 0.6441008449, alpha: 1)
            )
        }
        static var lightGray: UIColor {
            getThemeColor(
                light: #colorLiteral(red: 0.674200356, green: 0.7370157838, blue: 0.8256326318, alpha: 1),
                dark: #colorLiteral(red: 0.674200356, green: 0.7370157838, blue: 0.8256326318, alpha: 1)
            )
        }
    }
}
