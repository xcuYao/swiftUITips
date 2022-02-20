//
//  ThirdPartLibSection.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/12.
//

import SwiftUI

// https://github.com/dkk/WrappingHStack
// https://github.com/fatbobman/SheetKit

struct ThirdPartLibSection: View {
    
    @State private var select = 0

    let thirdPartLibs = ["WrappingHStack", "SheetKit", "WaterfallGrid", "SkeletonUI"]

    var body: some View {
        List() {
            Section(header: Text("三方库")) {
                ForEach(thirdPartLibs, id: \.self) { data in
                    NavigationLink(destination: {
                        ThirdPartLibExample(name: data)
                            .navigationBarTitle(Text(data), displayMode: .inline)
                    }) {
                        Text(data)
                    }
                }
            }
        }
    }
}

struct ThirdPartLibSection_Previews: PreviewProvider {

    static var previews: some View {
        ThirdPartLibSection()
    }
}
