//
//  SwiftUITipApp.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/6.
//

import SwiftUI

@main
struct SwiftUITipApp: App {

    init() {
        setupApperance()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 1000, height: 600, alignment: .top)
        }
    }
}

private extension SwiftUITipApp {
    func setupApperance() {
//        UITableView.appearance().backgroundColor = .clear
//        UITableViewCell.appearance().backgroundColor = .clear
    }
}
