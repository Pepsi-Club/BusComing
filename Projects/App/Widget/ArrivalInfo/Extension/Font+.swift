//
//  Font+.swift
//  Widget
//
//  Created by 유하은 on 4/17/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import SwiftUI
import DesignSystem

extension Font {
    static func nanumLight(_ size: CGFloat) -> Font {
        return DesignSystemFontFamily.NanumSquareNeoOTF.light.swiftUIFont(
            size: size
        )
    }
    
    static func nanumRegular(_ size: CGFloat) -> Font {
        return DesignSystemFontFamily.NanumSquareNeoOTF.regular.swiftUIFont(
            size: size
        )
    }
    
    static func nanumBold(_ size: CGFloat) -> Font {
        return DesignSystemFontFamily.NanumSquareNeoOTF.bold.swiftUIFont(
            size: size
        )
    }
    
    static func nanumExtraBold(_ size: CGFloat) -> Font {
        return DesignSystemFontFamily.NanumSquareNeoOTF.extraBold.swiftUIFont(
            size: size
        )
    }
    
    static func nanumHeavy(_ size: CGFloat) -> Font {
        return DesignSystemFontFamily.NanumSquareNeoOTF.heavy.swiftUIFont(
            size: size
        )
    }
}
