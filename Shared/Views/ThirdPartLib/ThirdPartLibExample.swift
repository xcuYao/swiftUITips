//
//  ThirdPartLibExample.swift
//  SwiftUITip (iOS)
//
//  Created by yaoning on 2022/2/4.
//

import SwiftUI

//let thirdPartLibs = ["WrappingHStack", "NavigationViewKit", "SheetKit", "SwipeCell", "ASCollectionView"]

struct ThirdPartLibExample: View {
    
    var name: String
    
    var body: some View {
        Text("\(name)")
    }
}

struct ThirdPartLibExample_Previews: PreviewProvider {
    static var previews: some View {
        ThirdPartLibExample(name: "WrappingHStack")
    }
}
