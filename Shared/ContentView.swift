//
//  ContentView.swift
//  Shared
//
//  Created by yaoning on 2022/1/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Int = 0

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                SystemElement()
                    .tabItem({
                        Image(systemName: "apps.iphone")
                        Text("系统组件")
                    })
                    .tag(0)
                Tab2()
                    .tabItem({
                        Image(systemName: "rectangle.leadinghalf.filled")
                        Text("状态管理")
                    })
                    .tag(1)
                Tab3()
                    .tabItem({
                        Image(systemName: "antenna.radiowaves.left.and.right")
                        Text("三方组件")
                    })
                    .tag(2)
            }.navigationBarTitle("SwiftUITip")
        }.accentColor(Color(hex: "#FC8960"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
