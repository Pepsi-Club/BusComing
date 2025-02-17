//
//  SearchTVBackgroundView.swift
//  SearchFeature
//
//  Created by gnksbm on 3/15/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import UIKit

import DesignSystem

final class SearchTVBackgroundView: UIView {
    let descriptionLabel: UILabel = {
        let label = UILabel()
        let font = DesignSystemFontFamily.NanumSquareNeoOTF.regular.font(
            size: 13
        )
        label.font = font
        label.textAlignment = .center
        label.textColor = DesignSystemAsset.gray5.color
        return label
    }()
    
    convenience init(text: String) {
        self.init()
        descriptionLabel.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [descriptionLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
