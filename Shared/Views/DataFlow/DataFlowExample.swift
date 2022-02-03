//
//  DataFlowExample.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/31.
//

import SwiftUI
import WebKit

// @State
// @Published @ObservedObject @StateObject
// @EnvironmentObject @Environment
// @Binding
// @GestureState

struct DataFlowExample: View {
    var name: String

    var body: some View {

        switch name {
        case "@State":
            StateExample()
        case "@Published", "@ObservedObject", "@StateObject":
            PublishedExample()
        case "@EnvironmentObject", "@Environment":
            EnvironmentExample()
        case "@Binding":
            BindingExample()
        case "@GestureState":
            GestureStateExample()
        default:
            Text("DataFlowExample")
        }
    }
}

struct StateExample: View {

    @State private var count = 0

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Click count: \(count)")
            Button(action: {
                count += 1
            }, label: {
                Text("点我").foregroundColor(Color.black).font(.title2)
            })
        }
    }
}

struct PublishedExample: View {

    // 包含@Published包装的属性 需要实现ObservableObject协议
    // 实现该协议的方法 都会默认实现 objectWillChange 方法
    class DataViewModel: ObservableObject {
        @Published var value: Int = 0
        init() {
            for i in 0...10 {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                    self.value += 1
                }
            }
        }
    }

    @ObservedObject var viewModel = DataViewModel()

    var body: some View {
        Text("PublishedExample")
        VStack(spacing: 10) {
            Text("监听了ViewModel中的@Publish属性")
            Text("Value:\(viewModel.value)")
        }
    }
}



struct EnvironmentExample: View {
    
    class User: ObservableObject {
        @Published var name = "Jack"
    }
    
    @Environment(\.colorScheme) var colorScheme

    let user = User()

    var body: some View {
        VStack(spacing: 10) {
            Text("EnvironmentExample")
                .foregroundColor(colorScheme == .light ? .yellow : .blue)
            SubView()
        }
        // 在此处注入 只在之后的组件中可以取到
            .environmentObject(user)
    }

    struct SubView: View {

        @EnvironmentObject var user: User

        var body: some View {
            Text("环境变量:\(user.name)")
        }
    }

}

// 一般将需要在上层组件中管理的属性 在子组件中使用@Binding修饰
// 这样就相当于获取了上层组件传递属性的引用 用作状态的关联
struct BindingExample: View {

    @State private var name: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("父组件: \(name)")
            TextField("父组件管理的属性:", text: $name)
            Divider()
            BindingChildView(name: $name)
        }.padding(20)
    }

    struct BindingChildView: View {

        @Binding var name: String

        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                Text("子组件: \(name)")
                TextField("子组件管理的属性:", text: $name)
            }
        }
    }
}

struct GestureStateExample: View {
    // 让手势结束后回到最初的状态
    @GestureState var isLongPress = false

    var body: some View {

        let longPress = LongPressGesture()
            .updating($isLongPress) { value, state, transcation in
            print(value)
            state = value
        }
        return Rectangle()
            .fill(isLongPress ? Color.red : Color.green)
            .frame(width: 300, height: 300, alignment: .center)
            .cornerRadius(10)
            .padding()
            .scaleEffect(isLongPress ? 1.2 : 1.0)
            .gesture(longPress)
            .animation(.interactiveSpring(), value: true)
    }
}

struct DataFlowExample_Preview: PreviewProvider {

    static var previews: some View {
        DataFlowExample(name: "@Published")
    }

}
