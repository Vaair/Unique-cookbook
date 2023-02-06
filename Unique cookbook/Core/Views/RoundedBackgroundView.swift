//
//  RoundedBackgroundView.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 01.02.2023.
//

import UIKit

class RoundedBackgroundView: UICollectionReusableView {
    private var insetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemFill
        view.layer.cornerRadius = Constants.cornerRadius
        view.clipsToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(insetView)
        
        insetView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(Constants.topIndent)
            make.bottom.equalToSuperview().inset(Constants.bottomIndent)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RoundedBackgroundView {
    enum Constants {
        static let cornerRadius = GlobalVariables.screenWidth.getValue(with: 3)
        static let topIndent = GlobalVariables.screenHeight.getValue(with: 0.5)
        static let bottomIndent = GlobalVariables.screenHeight.getValue(with: 1)
    }
}
