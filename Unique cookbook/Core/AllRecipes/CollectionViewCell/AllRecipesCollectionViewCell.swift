//
//  AllRecipesCollectionViewCell.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 20.01.2023.
//

import UIKit

class AllRecipesCollectionViewCell: UICollectionViewCell {
    var presenter: CollectionViewCellPresenterProtocol!
    
    private let icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = Constants.cornerRadius
        image.backgroundColor = .gray
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .CustomFont.recentlyCellTitle
        label.textColor = .label
        label.sizeToFit()
        label.numberOfLines = Constants.numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusView: StatusView = {
        let view = StatusView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let arrowIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = Constants.arrowIconImage
        image.tintColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configure() {
        titleLabel.text = presenter.getTitle()
        icon.image = presenter.getImage()
        statusView.configure(status: StatusView.StatusType(rawValue: presenter.getStatus()) ?? .notVerified)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        arrangeIcon()
        arrangeArrow()
        arrangeTitleLabel()
        arrangeStatusView()
        setupSeparator()
    }
    
    private func arrangeIcon() {
        contentView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.leading.bottom.top.equalToSuperview().inset(Constants.topBottomInsetIcon)
            make.trailing.equalTo(snp.leading).inset(Constants.widthIcon)
        }
    }
    
    private func arrangeTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.top).inset(frame.height.getValue(with: Constants.topTitleLabel))
            make.leading.equalTo(icon.snp.trailing).inset(frame.height.getValue(with: -Constants.leadingTitlePercent))
            make.trailing.equalTo(arrowIcon.snp.leading).inset(-Constants.topBottomInsetIcon)
        }
    }
    
    private func arrangeStatusView() {
        contentView.addSubview(statusView)
        statusView.snp.makeConstraints { make in
            make.bottom.equalTo(icon.snp.bottom).inset(frame.height.getValue(with: Constants.bottomStatusView))
            make.leading.equalTo(icon.snp.trailing).inset(frame.height.getValue(with: -Constants.leadingTitlePercent))
            make.height.equalToSuperview().multipliedBy(Constants.heightStatusViewMultiplier)
        }
    }
    
    private func arrangeArrow() {
        contentView.addSubview(arrowIcon)
        arrowIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupSeparator() {
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
            make.leading.equalTo(snp.leading).inset(Constants.leadingInsetSeparator + Constants.widthIcon)
            make.height.equalToSuperview().multipliedBy(Constants.heightSeparatorPercent)
        }
    }
}

extension AllRecipesCollectionViewCell: CollectionViewCellProtocol {
    
}

extension AllRecipesCollectionViewCell {
    enum Constants {
        static let cornerRadius = GlobalVariables.screenWidth.getValue(with: 2)
        static let numberOfLines = 2
        static var bottomIconPercent: Float = 30
        static let topTitleLabel: Float = 10
        static let arrowIconImage = UIImage(systemName: "arrow.right")
        static var widthIcon = GlobalVariables.screenWidth.getValue(with: 30)
        static var leadingTitlePercent: Float = 10
        static let bottomStatusView: Float = 10
        static var heightStatusViewMultiplier: Float = 0.17
        static let heightSeparatorPercent = 0.01
        static let leadingInsetSeparator = GlobalVariables.screenWidth.getValue(with: 1)
        static let topBottomInsetIcon = GlobalVariables.screenWidth.getValue(with: 2)
    }
}
