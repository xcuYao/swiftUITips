//
//  ThirdPartLibExample.swift
//  SwiftUITip (iOS)
//
//  Created by yaoning on 2022/2/4.
//

import SwiftUI
import WaterfallGrid
import SheetKit
import WrappingHStack
import SkeletonUI

//let thirdPartLibs = ["WrappingHStack", "SheetKit", "ASCollectionView"]

struct ThirdPartLibExample: View {

    var name: String

    var body: some View {
        switch name {
        case "WrappingHStack":
            WrappingHStackExample()
        case "SheetKit":
            SheetKitExample()
        case "ASCollectionView":
            ASCollectionViewExample()
        case "WaterfallGrid":
            WaterfallGridExample()
        case "SkeletonUI":
            SkeletonUIExample()
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
            WrappingHStack(1...20, id: \.self) {
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

struct ASCollectionViewExample: View {
    var body: some View {
        Text("ASCollectionViewExample")
    }
}

struct WaterfallGridExample: View {

    var images = Array(0..<22).map { "image\($0)" }.shuffled()

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            WaterfallGrid(images, id: \.self) { image in
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }.padding(20)
        }
    }
}

struct SkeletonUIExample: View {

    struct User: Identifiable {
        let id = UUID()
        let name: String
    }

    @State var users = [User]()
    var body: some View {
        SkeletonList(with: users, quantity: 6) { loading, user in
            Text(user?.name)
                .skeleton(with: loading)
                .shape(type: .rectangle)
                .appearance(type: .solid(color: .red, background: .blue))
                .multiline(lines: 3, scales: [1: 0.5])
                .animation(type: .pulse())
        }
            .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.users = [User(name: "John Doe"),
                              User(name: "Jane Doe"),
                              User(name: "James Doe"),
                              User(name: "Judy Doe")]
            }
        }
    }
}

struct ThirdPartLibExample_Previews: PreviewProvider {
    static var previews: some View {
        ThirdPartLibExample(name: "SheetKit")
    }
}
