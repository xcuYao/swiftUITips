//
//  ThirdPartLibExample.swift
//  SwiftUITip (iOS)
//
//  Created by yaoning on 2022/2/4.
//

import SwiftUI

//let thirdPartLibs = ["WrappingHStack", "SheetKit", "SwipeCell", "ASCollectionView"]

struct ThirdPartLibExample: View {

    var name: String

    var body: some View {
        switch name {
        case "WrappingHStack":
            WrappingHStackExample()
        case "SheetKit":
            SheetKitExample()
        case "SwipeCell":
            SwipeCellExample()
        case "ASCollectionView":
            ASCollectionViewExample()
        default:
            Text("ThirdPartLibExample")
        }
    }
}

struct WrappingHStackExample: View {
    var body: some View {
        WrappingHStack(spacing: .constant(10)) {
            Text("大号文字").font(.title).padding().border(.blue, width: 1)
            Text("踔厉奋发、笃行不怠")
            Image(systemName: "scribble")
                    .font(.title)
                    .frame(width: 200, height: 20)
                    .background(Color.purple)
            Text("and loop")
                    .bold()
                WrappingHStack(1...20, id:\.self) {
                    Text("Item: \($0)")
                        .padding(3)
                        .background(Rectangle().stroke())
                }.frame(minWidth: 250)
        }.padding(20)
            .border(Color.black, width: 2)
    }
}

struct SheetKitExample: View {
    
    @Environment(\.sheetKit) var sheetKit
    
    var body: some View {
        VStack {
            MyButton(label: "sheet1", font: .footnote, action: {
                SheetKit().present {
                    SheetKitExample()
                }
            })
            MyButton(label: "sheet2", font: .footnote, action: {
                sheetKit.present(with: .bottomSheet, afterPresent: {
                    print("afterPresent")
                }, onDisappear: {
                    print("onDisappear")
                }, content: {
                    SheetKitExample()
                })
            })
            MyButton(label: "Dismiss One", font: .footnote, action: {
                // dismiss current
                SheetKit().dismiss()
            })
            MyButton(label: "Dismiss All", font: .footnote, action: {
                // dismiss current
                SheetKit().dismissAllSheets()
            })
        }
    }
}

struct SwipeCellExample: View {
    var body: some View {
        Text("SwipeCellExample")
    }
}

struct ASCollectionViewExample: View {
    var body: some View {
        Text("ASCollectionViewExample")
    }
}

struct ThirdPartLibExample_Previews: PreviewProvider {
    static var previews: some View {
        ThirdPartLibExample(name: "SheetKit")
    }
}
