//
//  DataFlowSection.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/10.
//

import SwiftUI

struct DataFlowSection: View {

    // @State
    // @Published @ObservedObject @StateObject
    // @EnvironmentObject @Environment
    // @Binding
    // @GestureState

    @State private var select = 0

    //sections 基础组件 容器类组件 功能组件 动画图形 其他
    let dataFlows = ["@State", "@Published", "@ObservedObject", "@StateObject", "@EnvironmentObject", "@Environment", "@Binding", "@GestureState"]

    var body: some View {
        List() {
            Section(header: Text("数据流")) {
                ForEach(dataFlows, id: \.self) { data in
                    NavigationLink(destination: {
                        DataFlowExample(name: data)
                    }) {
                        Text(data)
                    }
                }
            }
        }
    }
}

struct Tab2_Previews: PreviewProvider {
    static var previews: some View {
        DataFlowSection()
    }
}
