//
//  LayoutElement.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/22.
//

import SwiftUI

struct LayoutElement: View {

    @State var name: String = "HStack"

    var body: some View {
        switch name {
        case "HStack":
            HStackExample()
        case "VStack":
            VStackExample()
        case "ZStack":
            ZStackExample()
        default:
            Text("Default")
        }
    }
}

struct HStackExample: View {
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 20) {
                ForEach(0...5, id: \.self) { i in
                    HStack { Text(String(i)).foregroundColor(.white) }.frame(width: 40, height: 40, alignment: .center).background(.red).cornerRadius(10)
                }
                Spacer()
            }.padding(20).background(Color.green)
            HStack(alignment: .center, spacing: 20) {
                Spacer()
                ForEach(0...5, id: \.self) { i in
                    HStack { Text(String(i)).foregroundColor(.white) }.frame(width: 40, height: 40, alignment: .center).background(.red).cornerRadius(10)
                }
            }.padding(20).background(Color.green)
            Spacer()
        }.onAppear {
            print("HStackExample onAppear")
        }
    }
}

struct VStackExample: View {
    var body: some View {
        Text("VStack")
    }
}

struct ZStackExample: View {
    var body: some View {
        Text("ZStack")
    }
}

struct LayoutElement_Previews: PreviewProvider {
    static var previews: some View {
        LayoutElement(name: "HStack")
    }
}
