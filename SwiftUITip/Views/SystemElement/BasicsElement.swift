//
//  BasicsElement.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/18.
//

import SwiftUI

struct BasicsElement: View {

    @State var name: String = "Text"

    var body: some View {
        switch name {
        case "Text":
            TextExample()
        case "Button":
            ButtonExample()
        case "Image":
            ImageExample()
        case "Toggle":
            ToggleExample()
        case "Label":
            LabelExample()
        case "TextField":
            TextFieldExample()
        default:
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

private struct TextExample: View {

    @State var actionText = "点我变化"

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("SwiftUI 从入门到放弃")
                .foregroundColor(Color.white)
                .background(Color.black)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .font(Font.system(size: 16))
            Divider()
            Text("SwiftUI 系统字体")
                .foregroundColor(Color.black)
                .font(Font.custom("Herculanum", size: 12))
                .padding(10)
            Divider()
            HStack(spacing: 10) {
                Text("SwiftUI").foregroundColor(Color.red) +
                    Text(" Is").foregroundColor(Color.green) +
                    Text(" Good").foregroundColor(Color.blue)
                Text("UnderLine").underline(true, color: .black)
                Text("google无法访问").foregroundColor(Color.blue).strikethrough(true, color: .black)
                Text("Bold").fontWeight(.bold)
                Text("thin").fontWeight(.thin)
                Text("ultraLight").fontWeight(.ultraLight)
                Text("italic").italic()
                Text(actionText).onTapGesture {
                    tapHandler()
                }
            }.padding(10)
            Divider()
            //  kerning&tracking区别  http://whatisdesign.lofter.com/post/341297_1623b0c
            VStack(alignment: .leading, spacing: 10) {
                Text("字距调整 Kerning").kerning(10)
                Text("字距 Tracking").tracking(10)
                HStack {
                    Text("基线偏移10").baselineOffset(10).background(Color.red)
                    Text("基线偏移-10").baselineOffset(-10).background(Color.red)
                }
            }.padding(10)
            Divider()
            VStack(alignment: .leading) {
                Text("最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行最多两行").lineLimit(2)
                HStack(alignment: .top) {
                    Text("MarkDown支持测试")
                    Text("[link](https://www.baidu.com)")
                    Text("*italic*")
                    Text("**Bold**")
                    Text("~Strikethrough~")
                    Text("`Hello world coder!!`")
                    Text("***[this](https://www.baidu.com) ~is~ `Cool`***")
                }.padding(10)
            }.padding(10)

            Spacer()
        }.background(Color.white)
            .cornerRadius(6)
    }

    func tapHandler() {
        actionText = "点我干哈？\(Int.random(in: 0...999))"
    }
}

private struct ButtonExample: View {
    var body: some View {
        VStack {
            // 初始化方式1
            Button(action: {
                print("click 1")
            }) {
                Text("JustButton")
            }
            // 初始化方式2
            Button("JustButton") {
                print("click 2")
            }
            //
            Button(action: { }) {
                Text("ColorButton1").foregroundColor(.white)
            }.padding(10)
                .buttonStyle(.plain)
                .background(.red)
                .cornerRadius(6)
        }
    }
}

private struct ImageExample: View {
    // 1. 修改图片尺寸 先resizable后调整frame 才会改变图片大小
    // 调用顺序会导致某些方法调不到 因为点语法每次返回的都是一个新的struct
    var body: some View {
        VStack {
            Image("swiftui")
            Image("swiftui")
                .resizable()
                .frame(width: 120, height: 120)
                .background(Color.mint)
                .border(.yellow, width: 3)
            VStack {
                Image("swiftui")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 40)
                    .background(Color.brown)
                Text("120*40 scaledToFit")
            }
            VStack {
                Image("swiftui")
                    .resizable()
                    .aspectRatio(20, contentMode: .fill)
                    .frame(width: 120, height: 40)
                    .fixedSize(horizontal: true, vertical: false)
                Text("120*40 scaledToFill")
            }
            VStack {
                //  此处查看所有系统图片
                // https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/
                Image(systemName: "bitcoinsign.square.fill")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(.blue)
                    .frame(width: 60, height: 60)
                Text("System image")
            }
        }
    }
}

private struct ToggleExample: View {

    @State var isOn = true

    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Section {
                    HStack {
                        Text("Default Toggle:")
                        Toggle(isOn: $isOn) {
                            Text("Toggle Test")
                        }
                    }
                }
                Section {
                    HStack {
                        Text("Custom Toggle:")
                        Toggle("Toggle Me", isOn: $isOn)
                            .toggleStyle(CustomToggleStyle())
                    }
                }
            }
            Spacer()
        }
    }

    struct CustomToggleStyle: ToggleStyle {
        func makeBody(configuration: Configuration) -> some View {
            Button(action: {
                configuration.isOn.toggle()
            }) {
                Label(title: {
                    configuration.label
                }, icon: {
                        Image(systemName: configuration.isOn ? "tray.fill" : "tray")
                    })
            }.buttonStyle(.plain)
        }
    }

}

private struct LabelExample: View {

    var body: some View {
        VStack {
            Label("Text", image: "swiftui")
        }
    }
}

private struct TextFieldExample: View {
    @State var value: String = ""
    @State private var label = "Currency (USD)"
    @State private var myMoney: Double? = 300.0

    // todo: macos上 框的背景 去不掉。。。
    var body: some View {
        VStack(alignment: .leading) {
            TextField("titleKey", text: $value)
            TextField("titleKey", text: $value, prompt: Text("prompt"))
                .background(RoundedRectangle(cornerRadius: 6).stroke(Color.blue))
                .frame(width: 100)
            TextField("UserName", text: $value)
                .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white.opacity(0.2))
                    .padding(.leading, 20)
            }.padding(.top)
                .padding(.bottom)
                .background(VisualEffectView())
            HStack {
                Image("swiftui").resizable().frame(width: 20, height: 20)
                TextField("圆角样式", text: $value)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            }
            HStack {
                TextField("自定义样式", text: $value)
                    .textFieldStyle(OvalTextFieldStyle())
            }
            TextField(label, value: $myMoney, format: .currency(code: "USD"))
                .onChange(of: myMoney) { newValue in
                print("handler change \(newValue ?? 0.0)")
            }
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search...", text: $value)
            }.modifier(customViewModifier(roundedCornes: 6, startColor: .orange, endColor: .purple, textColor: .white))
            HStack {
                TextField("Search...", text: $value).extensionTextFieldView(roundedCornes: 6, startColor: .white, endColor: .purple)
            }
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $value)
            }.underlineTextField()
            Spacer()
        }.padding(10)
    }

    struct VisualEffectView: NSViewRepresentable {
        func makeNSView(context: Context) -> NSVisualEffectView {
            let view = NSVisualEffectView()
            view.blendingMode = .behindWindow // << important !!
            view.isEmphasized = true
            view.material = .titlebar
            return view
        }

        func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        }
    }

    struct OvalTextFieldStyle: TextFieldStyle {
        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(10)
                .background(LinearGradient(gradient: Gradient(colors: [Color.accentColor, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(20)
                .shadow(color: .gray, radius: 10)
        }
    }

    struct customViewModifier: ViewModifier {
        var roundedCornes: CGFloat
        var startColor: Color
        var endColor: Color
        var textColor: Color

        func body(content: Content) -> some View {
            content
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(roundedCornes)
                .padding(3)
                .foregroundColor(textColor)
                .overlay(RoundedRectangle(cornerRadius: roundedCornes)
                    .stroke(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.5))
                .font(.custom("Open Sans", size: 18))

                .shadow(radius: 10)
        }
    }
}

//swiftUI层面不支持 曲线救国 去掉高亮效果
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}

extension TextField {
    func extensionTextFieldView(roundedCornes: CGFloat, startColor: Color, endColor: Color) -> some View {
        self
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(roundedCornes)
            .shadow(color: .purple, radius: 10)
    }
}

extension Color {
    static let darkPink = Color(red: 208 / 255, green: 45 / 255, blue: 208 / 255)
}

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(.darkPink)
            .padding(10)
    }
}

struct BasicsElement_Previews: PreviewProvider {
    static var previews: some View {
        BasicsElement(name: "Label")
    }
}
