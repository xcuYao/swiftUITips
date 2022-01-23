//
//  ColorExtension.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/23.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    public static var random: Color {
        Color(red:.random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), opacity: 1)
    }
}
