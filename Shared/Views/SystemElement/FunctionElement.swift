//
//  FunctionElement.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/28.
//

import SwiftUI

struct FunctionElement: View {
    
    @State var name: String = "Alert"
    var body: some View {
        switch name {
        case "Alert":
            AlertExample()
        case "Sheet":
            SheetExample()
        case "Popover":
            PopoverExample()
        case "Gesture":
            GestureExample()
        case "Map":
            MapExample()
        case "WebView":
            WebViewExample()
        default:
            Text("Default")
        }
    }
}

struct AlertExample: View {
    
    @State var alertShow = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Alert1", action: {
                alertShow = true
            }).alert("Alert1", isPresented: $alertShow) {
                Button("Ok", role: .cancel, action: { print("cancel alert 1") })
            }
            Button("Alert2", action: {
                alertShow = true
            }).alert("Alert2", isPresented: $alertShow) {
                Button("Button1", action: {})
                Button("Button2", action: {})
                Button("Button3", action: {})
            }
            Button("Alert3", action: {
                alertShow = true
            }).alert(isPresented: $alertShow) {
                Alert(title: Text("Title"), message: Text("Some message"), dismissButton: .cancel())
            }
        }
    }
}

struct SheetExample: View {
    var body: some View {
        Text("Sheet")
    }
}

struct PopoverExample: View {
    var body: some View {
        Text("Popover")
    }
}

struct GestureExample: View {
    var body: some View {
        Text("Gesture")
    }
}

struct MapExample: View {
    var body: some View {
        Text("Map")
    }
}

struct WebViewExample: View {
    var body: some View {
        Text("WebView")
    }
}

struct FunctionElement_Previews: PreviewProvider {
    static var previews: some View {
        FunctionElement()
    }
}
