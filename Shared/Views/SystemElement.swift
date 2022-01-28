//
//  SystemElement.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/10.
//

import SwiftUI

struct SystemElement: View {

    @State var select = 0

    //sections 基础组件 容器类组件 功能组件 动画图形 其他
    let basics = ["Text", "Button", "Image", "Toggle", "Label", "Slider", "TextField", "Picker", "DatePicker", "ProgressView", "Stepper"]
    let layouts = ["NavigationView", "TabView", "HStack/VStack/ZStack", "LazyStack", "List", "ScrollView", "Grid"]
    let function = ["Alert", "Sheet", "Popover", "Gesture", "Map", "WebView"]
    let animation = ["", "", ""]
    let other = ["Color", "Font", "Spacer", "Divider", "Gradient", "ViewBuilder", "Timer", "GeometryReader"]

    var body: some View {
        List() {
            Section(header: Text("基础组件")) {
                ForEach(basics, id: \.self) { data in
                    NavigationLink(destination: {
                        BasicsElement(name: data)
                    }) {
                        Text(data)
                    }
                }
            }
            Section(header: Text("容器类组件")) {
                ForEach(layouts, id: \.self) { data in
                    NavigationLink(data, destination: {
                        LayoutElement(name: data)
                    })
                }
            }
            Section(header: Text("功能组件")) {
                ForEach(function, id: \.self) { data in
                    NavigationLink(data, destination: {
                        FunctionElement(name: data)
                    })
                }
            }
            Section(header: Text("动画图形")) {
                ForEach(animation, id: \.self) { data in
                    Text(data)
                }
            }
            Section(header: Text("其他")) {
                ForEach(other, id: \.self) { data in
                    Text(data)
                }
            }
        }
    }
}

struct Tab1_Previews: PreviewProvider {
    static var previews: some View {
        SystemElement()
    }
}
