//
//  UIImage.swift
//  DesignSystem
//
//  Created by Muker on 4/11/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import UIKit
import AVFoundation

public extension UIImage {
    func resize(_ width: Int, _ height: Int) -> UIImage {
        let maxSize = CGSize(
            width: width,
            height: height
        )
        let availableRect = AVFoundation.AVMakeRect(
            aspectRatio: self.size,
            insideRect: .init(origin: .zero,
                              size: maxSize)
        )
        let targetSize = availableRect.size
        let format = UIGraphicsImageRendererFormat()
        let renderer = UIGraphicsImageRenderer(
            size: targetSize,
            format: format
        )
        let resized = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: targetSize
            ))
        }
        return resized
    }
}
