//
//  StatusView.swift
//  Unique cookbook
//
//  Created by Лера Тарасенко on 27.01.2023.
//

import UIKit

class StatusView: UIView {
    enum StatusType: Int {
        case notVerified = 0
        case verified
        case needsImprovement
        
        func getString() -> String {
            switch self {
            case .notVerified:
                return "not_verified_type".localized
            case .verified:
                return "verified_type".localized
            case .needsImprovement:
                return "needs_improvement_type".localized
            }
        }
        
        func getColor() -> UIColor {
            switch self {
            case .notVerified:
                return .CustomColors.red
            case .verified:
                return .CustomColors.green
            case .needsImprovement:
                return .CustomColors.orange
            }
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .CustomFont.status
        label.textColor = .white
        label.numberOfLines = Constants.numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(status: StatusType) {
        titleLabel.text = status.getString()
        backgroundColor = status.getColor()
        arrangeTitleLabel()
    }
    
    init() {
        super.init(frame: CGRect())
        self.snp.makeConstraints { make in
            make
                .width
                .equalTo(titleLabel.frame.width + GlobalVariables.screenWidth.getValue(
                    with: Constants.indentHorizontalProcent)
                )
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        arrangeTitleLabel()
        if titleLabel.frame.width != .zero {
            setupWidth()
        }
        layer.cornerRadius = frame.height / Constants.cornerRadiusDivider
    }
    
    private func setupWidth() {
        self.snp.updateConstraints { make in
            make
                .width
                .equalTo(titleLabel.frame.width + GlobalVariables.screenWidth.getValue(
                    with: Constants.indentHorizontalProcent)
                )
        }
    }
    
    private func arrangeTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make
                .top
                .bottom
                .centerX
                .equalToSuperview()
        }
    }
}

extension StatusView {
    enum Constants {
        static let indentHorizontalProcent: Float = 5
        static let numberOfLines = 1
        static let cornerRadiusDivider: CGFloat = 2
    }
}
