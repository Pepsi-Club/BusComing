//
//  BusStopInfoHeaderView.swift
//  BusStopFeatureDemo
//
//  Created by Jisoo HAM on 2/1/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import UIKit

import DesignSystem

import Lottie

public final class BusStopInfoHeaderView: UIView {
    
    public let navigationBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "chevron.left")
        config.baseForegroundColor = .white
        config.imagePadding = 7
        var imgConfig = UIImage.SymbolConfiguration(
            font: .systemFont(ofSize: 17)
        )
        imgConfig = UIImage.SymbolConfiguration(weight: .semibold)
        config.preferredSymbolConfigurationForImage = imgConfig
        let btn = UIButton(configuration: config)
        return btn
    }()
    
    private let busStopNumLb: UILabel = {
        let label = UILabel()
        label.font = DesignSystemFontFamily.NanumSquareNeoOTF
            .regular.font(size: 15)
        label.textColor = .white
        return label
    }()
    
    public let busStopNameLb: UILabel = {
        let label = UILabel()
        label.font = DesignSystemFontFamily.NanumSquareNeoOTF
            .extraBold.font(size: 18)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let nextStopNameLb: UILabel = {
        let label = UILabel()
        label.font = DesignSystemFontFamily.NanumSquareNeoOTF
            .bold.font(size: 14)
        label.textColor = DesignSystemAsset.gray2.color
        return label
    }()
    
    public let mapBtn: UIButton = {
        var config = UIButton.Configuration.filled()
        
        config.image = UIImage(systemName: "map")
        
        var title = AttributedString.init(stringLiteral: "지도")
        title.font = DesignSystemFontFamily.NanumSquareNeoOTF
            .regular.font(size: 10)
        config.attributedTitle = title
        config.baseBackgroundColor = .white
        config.baseForegroundColor = DesignSystemAsset.overnightBusColor.color
        config.imagePadding = 7
        let imgConfig = UIImage.SymbolConfiguration(
            font: .systemFont(ofSize: 11)
        )
        config.preferredSymbolConfigurationForImage = imgConfig
        config.cornerStyle = .capsule
        let btn = UIButton(configuration: config)
        return btn
    }()
    
    public let busStopIcon: LottieAnimationView = {
        let imgView = LottieAnimationView(
            name: "goingBus",
            configuration: LottieConfiguration(renderingEngine: .mainThread)
        )
        imgView.contentMode = .scaleAspectFit
        imgView.loopMode = .loop
        imgView.animationSpeed = 0.5
        imgView.play()
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bindUI(
        routeId: String?,
        busStopName: String,
        nextStopName: String
    ) {
            busStopNumLb.text = routeId
            busStopNameLb.text = busStopName
            nextStopNameLb.text = nextStopName + " 방면"
    }
}

extension BusStopInfoHeaderView {
    private func configureUI() {
        
        addSubview(navigationBtn)
        navigationBtn.translatesAutoresizingMaskIntoConstraints = false
        
        [busStopNumLb, busStopNameLb,
         nextStopNameLb, mapBtn]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                addSubview($0)
                $0.centerXAnchor.constraint(
                    equalTo: centerXAnchor
                ).isActive = true
            }
        
        NSLayoutConstraint.activate([
           
            busStopNumLb.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 25
            ),
            busStopNumLb.heightAnchor.constraint(equalToConstant: 15),
            busStopNameLb.topAnchor.constraint(
                equalTo: busStopNumLb.bottomAnchor,
                constant: 10
            ),
            busStopNameLb.heightAnchor.constraint(equalToConstant: 18),
            busStopNameLb.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 15
            ),
            busStopNameLb.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -15
            ),
            nextStopNameLb.topAnchor.constraint(
                equalTo: busStopNameLb.bottomAnchor,
                constant: 10
            ),
            nextStopNameLb.heightAnchor.constraint(equalToConstant: 15),
            mapBtn.topAnchor.constraint(
                equalTo: nextStopNameLb.bottomAnchor,
                constant: 20
            ),
            mapBtn.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -10
            ),
            mapBtn.heightAnchor.constraint(equalToConstant: 25),
            navigationBtn.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 0
            ),
            navigationBtn.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 0
            ),
//            busStopIcon.topAnchor.constraint(
//                equalTo: mapBtn.topAnchor,
//                constant: -50
//            ),
//            busStopIcon.widthAnchor.constraint(
//                equalToConstant: busStopIcon.intrinsicContentSize.width
//            ),
//            busStopIcon.heightAnchor.constraint(
//                equalToConstant: 100
//            ),
        ])
    }
}
