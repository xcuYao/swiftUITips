//
//  FunctionElement.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/28.
//

import SwiftUI
import MapKit

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
                Button("Button1", action: { })
                Button("Button2", action: { })
                Button("Button3", action: { })
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

    @State var sheetShow = false
    @State var sheetShow2 = false

    var body: some View {

        VStack(spacing: 20) {
            Button("Show Sheet") {
                sheetShow = true
            }.frame(width: 120, height: 40)
                .background(Color.random)
                .foregroundColor(.white)
                .cornerRadius(20)
                .sheet(isPresented: $sheetShow, onDismiss: {
                print("dismiss")
            }, content: {
                showView(name: "Just show")
            })
            Button("Full Screen") {
                sheetShow2 = true
            }.frame(width: 120, height: 40)
                .background(Color.random)
                .foregroundColor(.white)
                .cornerRadius(20)
                .fullScreenCover(isPresented: $sheetShow2, onDismiss: {
                print("dismiss")
            }, content: {
                showView(name: "FullScreen")
            })
        }
    }

    struct showView: View {
        var name: String
        @Environment(\.presentationMode) var presentationMode
        var body: some View {
            VStack {
                Text(name)
                Button("dismiss", action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) .foregroundColor(.white)
                    .frame(width: 120, height: 40)
                    .background(.random)
                    .cornerRadius(20)
            }
        }
    }

}

struct PopoverExample: View {
    // 个人感觉很难用 期待好用的三方库
    @State var popoverShow = false
    var body: some View {
//        VStack {
            Button("Popover") {
                popoverShow = true
            }.frame(width: 120, height: 40)
                .background(Color.random)
                .foregroundColor(.white)
                .cornerRadius(20)
                .popover(isPresented: $popoverShow,
                         // 不知道为啥不管用
                         arrowEdge: .top,
                         content: {
                    Text("AA")
                })
//        }
    }
}

struct GestureExample: View {
    var body: some View {
        Text("Gesture")
    }
}

struct MapExample: View {
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:34.762474, longitude: 113.705754), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    private var pointsOfInterest = [
        AnnotatedItem(name: "L1", coordinate: .init(latitude: 34.762055, longitude: 113.706711)),
        AnnotatedItem(name: "L2", coordinate: .init(latitude: 34.760704, longitude: 113.705415)),
        ]
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: pointsOfInterest) { item in
//            MapMarker(coordinate: item.coordinate)
            // 自定义大头针
            MapAnnotation(coordinate: item.coordinate) {
                RoundedRectangle(cornerRadius: 5.0)
                    .stroke(Color.purple, lineWidth: 4.0)
                    .frame(width: 30, height: 30)
            }
        }
            .edgesIgnoringSafeArea(.all)
    }
    
    struct AnnotatedItem: Identifiable {
        let id = UUID()
        var name: String
        var coordinate: CLLocationCoordinate2D
    }
    
}

struct WebViewExample: View {
    var body: some View {
        Text("WebView")
    }
}

struct FunctionElement_Previews: PreviewProvider {
    static var previews: some View {
        FunctionElement(name: "Map")
//            .previewDevice("iPad (8th generation)")
//            .previewDisplayName("iPad")
    }
}
