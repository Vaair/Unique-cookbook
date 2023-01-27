//
//  RecantlyCollectionViewCell.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 20.01.2023.
//

import UIKit
import SnapKit

class RecentlyCollectionViewCell: UICollectionViewCell {
    var presenter: AllCollectionViewCellPresenterProtocol!
    
    let icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = Constants.cornerRadius
        image.backgroundColor = .gray
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .CustomFont.recentlyCellTitle
        label.textColor = .label
        label.sizeToFit()
        label.numberOfLines = Constants.numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure() {
        titleLabel.text = presenter.getTitle()
        icon.image = presenter.getImage()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        arrangeIcon()
        arrangeTitleLabel()
    }
    
    private func arrangeIcon() {
        contentView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(
                frame.height.getValue(with: Constants.bottomIconPercent)
            )
        }
    }
    
    private func arrangeTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).inset(frame.height.getValue(with: -Constants.topTitleLabel))
            make.leading.trailing.equalToSuperview()
        }
    }
    
    
}

extension RecentlyCollectionViewCell {
    enum Constants {
        static let reuseId = "RecentlyCollectionViewCell"
        static let cornerRadius = GlobalConstants.screenWidth.getValue(with: 2)
        static let numberOfLines = 2
        static var bottomIconPercent: Float = 30
        static let topTitleLabel: Float = 5
    }
}
