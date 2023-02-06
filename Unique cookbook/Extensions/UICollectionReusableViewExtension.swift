//
//  UICollectionReusableViewExtension.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 01.02.2023.
//

import UIKit

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
