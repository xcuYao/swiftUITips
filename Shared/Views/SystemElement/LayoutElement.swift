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
        case "LazyStack":
            LazyStackExample()
        case "List":
            ListExample()
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
        }
    }
}

struct VStackExample: View {
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 20) {
                ForEach(0...5, id: \.self) { i in
                    HStack { Text(String(i)).foregroundColor(.white) }.frame(width: 40, height: 40, alignment: .center).background(.red).cornerRadius(10)
                }
                Spacer()
            }.padding(20).background(Color.green)
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                ForEach(0...5, id: \.self) { i in
                    HStack { Text(String(i)).foregroundColor(.white) }.frame(width: 40, height: 40, alignment: .center).background(.red).cornerRadius(10)
                }
            }.padding(20).background(Color.green)
            Spacer()
        }
    }
}

struct ZStackExample: View {
    var body: some View {
        HStack {
            VStack {
                ZStack() {
                    ForEach(0...5, id: \.self) { i in
                        HStack { Text(String(i)).foregroundColor(.white) }.frame(width: 40, height: 40, alignment: .center).background(.random).cornerRadius(10).offset(x: CGFloat(i * 10), y: CGFloat(i * 30))
                    }
                    Spacer()
                }.frame(width: 100, height: 300, alignment: .top).padding(20).background(Color.green).clipped()
            }
            Spacer()
        }
    }
}

struct LazyStackExample: View {
    var body: some View {
        HStack(alignment: .top) {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(0...10000, id: \.self) {
                        Text("Column \($0)")
                    }
                }
            }.frame(height: 40, alignment: .leading)
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(0...10000, id: \.self) {
                        Text("Row \($0)")
                    }
                }
            }.frame(width: 100, alignment: .leading)
            Spacer()
        }.padding(20)
    }
}

struct ListExample: View {
    var body: some View {
        List{
            Text("1")
            Text("2")
            Text("3")
        }
    }
}

struct LayoutElement_Previews: PreviewProvider {
    static var previews: some View {
        LayoutElement(name: "List")
    }
}
