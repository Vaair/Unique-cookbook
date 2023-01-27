//
//  BundleExtension.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 13.01.2023.
//

import Foundation

extension Bundle {
    private static var bundle: Bundle!
    
    public static func localizedBundle() -> Bundle {
        if bundle == nil {
            let appLang = UserDefaults.standard.string(
                forKey: "app_lang"
            ) ?? "ru"
            
             if let path = Bundle.main.path(
                forResource: appLang,
                ofType: "lproj"
               ) {
                bundle = Bundle(path: path)
            }
        }
        
        return bundle
    }
}
