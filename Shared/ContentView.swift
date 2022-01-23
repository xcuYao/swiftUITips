//
//  ContentView.swift
//  Shared
//
//  Created by yaoning on 2022/1/23.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Int = 4

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                SystemElement()
                    .tabItem({ Text("系统组件") })
                    .tag(0)
                Tab2()
                    .tabItem({ Text("状态管理") })
                    .tag(1)
                Tab3()
                    .tabItem({ Text("三方组件") })
                    .tag(2)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
