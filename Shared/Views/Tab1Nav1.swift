//
//  Tab1Nav1.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/12.
//

import SwiftUI

struct Tab1Nav1: View {
    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Hello Tab1Nav1")
//            }
//            .navigationTitle("Tab1Nav1")
//        }
//        NavigationLink(destination: Text("Detail View")) {
//            Text("Tab1Nav1")
//        }
        VStack {
            NavigationLink(destination: Text("aaa")) {
                Text("aaaaa")
            }
            NavigationLink(destination: Text("bbb")) {
                Text("bbbbb")
            }
        }.navigationTitle("Tab1Nav1")
    }
}

struct Tab1Nav1_Previews: PreviewProvider {
    static var previews: some View {
        Tab1Nav1()
    }
}
