//
//  ObserverTest.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/6.
//

import SwiftUI

class Human: ObservableObject {
    @Published var name: String
    @Published var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    func happyBirthday() {
        self.name = "Happy birthday"
        self.age += 1
    }

}

struct ObserverTest: View {
    
    @ObservedObject var john = Human(name: "john", age: 24)
    
    var body: some View {
        VStack {
            Text(john.name)
            ObserverTestSubView().environmentObject(john)
            Button(action: {
                john.happyBirthday()
            }, label: {
                Text(String(john.age))
            })
        }
        
    }
}

struct ObserverTestSubView: View {
    @EnvironmentObject var john: Human
    
    var body: some View {
        Text("sub \(john.age)")
    }
}

struct ObserverTest_Previews: PreviewProvider {
    static var previews: some View {
        ObserverTest()
    }
}
