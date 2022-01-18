//
//  SystemElement.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/10.
//

import SwiftUI

struct SystemElement: View {
    
    @State var select = 0
    
    //sections 基础组件 布局组件 功能组件 事件手势 动画图形 新特性 其他
    let basics = ["Text", "Button", "Image", "Toggle", "Slider", "TextField", "Picker", "DataPicker", "SegmentedControl"]
    let layout = ["HStack", "VStack", "ZStack", "List", "ScrollView", "Table", "Form"]
    let function = ["sheet", "NavigationView", "TabView"]
    let gesture = ["TapGesture", "LongPressGesture", "DragGesture", "Alert", "ActionSheet", "Popover"]
    let animation = ["", "", ""]
    let feature = ["ViewBuilder"]
    let other = ["color", "font", "Spacer", "Divider"]

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
            Section(header: Text("布局组件")) {
                ForEach(layout, id: \.self) { data in
                    Text(data)
                }
            }
            Section(header: Text("功能组件")) {
                ForEach(function, id: \.self) { data in
                    Text(data)
                }
            }
            Section(header: Text("事件手势")) {
                ForEach(gesture, id: \.self) { data in
                    Text(data)
                }
            }
            Section(header: Text("动画图形")) {
                ForEach(animation, id: \.self) { data in
                    Text(data)
                }
            }
            Section(header: Text("新特性")) {
                ForEach(feature, id: \.self) { data in
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
