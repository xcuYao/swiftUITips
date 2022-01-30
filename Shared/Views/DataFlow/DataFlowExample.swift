//
//  DataFlowExample.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/31.
//

import SwiftUI

struct DataFlowExample: View {
    var name: String
    var body: some View {
        Text("DataFlowExample")
    }
}

struct DataFlowExample_Preview: PreviewProvider {

    static var previews: some View {
        DataFlowExample(name: "@State")
    }

}
