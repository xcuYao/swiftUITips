//
//  Button.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/30.
//

import SwiftUI

struct TipButton: View {

    let label: String
    var font: Font = Font.system(size: 14)
    var textColor: Color = .white
    var action: () -> ()

    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Text(label)
                .font(font)
                .padding(10)
                .frame(minWidth: 70)
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.green).shadow(radius: 2))
                .foregroundColor(textColor)
        })
    }
}
