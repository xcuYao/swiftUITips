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
        case "Slider":
            SliderExample()
        case "Picker":
            PickerExample()
        case "DatePicker":
            DatePickerExample()
        case "SegmentedControl":
            SegmentedControlExample()
        case "ProgressView":
            ProgressViewExample()
        case "Stepper":
            StepperExample()
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
                Text("JustButton").padding(20)
            }
            // 初始化方式2
            Button("自定义样式") {
                print("click 2")
            }.buttonStyle(customButtonStyle(color: .green))
            //
            Button(action: { }) {
                Text("简单样式").foregroundColor(.white)
            }.padding(10)
                .buttonStyle(.plain)
                .background(.red)
                .cornerRadius(6)
            //
            Button("长按1s试试") {
                print("click 3")
            }.buttonStyle(customButtonStyle(color: .green))
        }
    }
    
    struct customButtonStyle: ButtonStyle {
        var color:Color = .blue
        func makeBody(configuration: Configuration) -> some View {
            configuration.label.foregroundColor(.white)
                .padding(20)
                .background(RoundedRectangle(cornerRadius: 6).fill(color))
                .compositingGroup()
                .shadow(color: .yellow, radius: 6)
                .opacity(configuration.isPressed ? 0.5 :1.0)
                .scaleEffect(configuration.isPressed ? 0.8 :1.0)
        }
    }
    
    struct customButtonStyle2: PrimitiveButtonStyle {
        var color:Color = .blue
        func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
            LongPressButton(configuration: configuration, color: color)
        }
        struct LongPressButton: View {
            let configuration: PrimitiveButtonStyle.Configuration
            let color: Color
            var body: some View {
                 Text("aa")
            }
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
        VStack(alignment: .leading, spacing: 10) {
            Label("SwiftUI", image: "swiftui")
            Label("剪贴", systemImage: "scissors")
                .font(.largeTitle)
                .foregroundColor(.blue)
            Label(title: {
                Text("剪贴")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.green)
            }, icon: {
                Image(systemName: "scissors")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            })
            Label(title: {
                Image(systemName: "scissors")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }, icon: {
                Text("剪贴")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.green)
            })
            Label("SwiftUI", image: "swiftui")
                .labelStyle(IconOnlyLabelStyle())
            Label("SwiftUI", image: "swiftui")
                .labelStyle(TitleOnlyLabelStyle())
            Label("SwiftUI", image: "swiftui")
                .labelStyle(TitleAndIconLabelStyle())
            Label("自定义Style", systemImage: "suit.heart.fill")
                .labelStyle(MyLabelStyle(color: .red))
        }
    }
    
    struct MyLabelStyle: LabelStyle {
        let color: Color
        
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                configuration.icon
                    .padding(10)
                    .background(Circle().fill(color))
                
                configuration.title
                    .padding(.trailing, 10)
                    .lineLimit(1)
            }
            .padding(6)
            .background(RoundedRectangle(cornerRadius: 10).stroke(color, lineWidth: 3))
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

private struct SliderExample: View {
    
    @State var value: Double = 5
    var body: some View {
        VStack{
            VStack {
                Text("Slider Value: \(value)")
                Slider(value: $value, in: 0...10)
                    .frame(width: 200, height: 20, alignment: .top)
            }.padding(20)
            Divider()
            VStack{
                Text("Step Value: \(value)")
                Slider(value: $value, in: 0...10, step: 1.0) {
                    Text("标题:")
                } onEditingChanged: { bool in
                    let str = bool ?"开始" :"结束"
                    print("状态:\(str)")
                }.frame(width: 300, height: 20, alignment: .leading)
            }.padding(20)
            Divider()
            VStack {
                Text("Max Min Value: \(value)")
                Slider(value: $value, in: -100...100, label: {EmptyView()}, minimumValueLabel: {Text("-100")}, maximumValueLabel: { Text("100") })
            }.padding(20)
            Spacer(minLength: 20)
        }
    }
}

private struct PickerExample: View {
    @State var selection = 0
    
    var devices = ["iPhone", "iPad", "Mac", "iWatch"]
    @State var selectDevice = "iPhone"
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker(selection: $selection, content: {
                Text("Value0").tag(0)
                Text("Value1").tag(1)
                Text("Value2").tag(2)
            }, label: {
                Text("Tag:\(selection)")
            }).frame(width: 400, height: 40)
            Picker(selection: $selectDevice, label: Text("Decice:\(selectDevice)")) {
                ForEach(devices, id: \.self) { device in
                    Text(device)
                }
            }.frame(width: 400, height: 40)
                .pickerStyle(SegmentedPickerStyle())
            Spacer()
        }.padding(20)
    }
}

private struct DatePickerExample: View {
    @State var selection = Date()
    let beginDate = Date()
    var endDate = Date()
    init() {
        endDate = beginDate.addingTimeInterval(60 * 60 * 24)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack {
                Text("\(selection)")
                DatePicker("date", selection: $selection, in: beginDate...endDate, displayedComponents: .date)
                    .frame(width: 300, height: 20)
                DatePicker("hourAndMinute", selection: $selection, in: beginDate...endDate, displayedComponents: .hourAndMinute)
                    .frame(width: 300, height: 20)
            }.padding(20)
            Divider()
            HStack {
                DatePicker(selection: $selection, label: {
                    Image(systemName: "airplane")
                    Text("compact Style")
                }).frame(width: 400, height: 20)
                    .datePickerStyle(.compact)
            }
            DatePicker(selection: $selection, label: {
                Image(systemName: "airplane")
                Text("field Style")
            }).frame(width: 400, height: 20)
                .datePickerStyle(.field)
            DatePicker(selection: $selection, label: {
                Image(systemName: "airplane")
                Text("graphical Style")
            }).frame(width: 400, height: 200)
                .datePickerStyle(.graphical)
            DatePicker(selection: $selection, label: {
                Image(systemName: "airplane")
                Text("graphical Style")
            }).frame(width: 400, height: 20)
                .datePickerStyle(.stepperField)
            Divider()
            Spacer()
        }
        
    }
}

private struct SegmentedControlExample: View {
    
    @State var selection:Int = 0

    var body: some View {
        Picker("", selection: self.$selection){
            Text("iPhone").tag(0)
            Text("iPad").tag(1)
            Text("iWatch").tag(2)
        }.pickerStyle(SegmentedPickerStyle()) 
    }
}

private struct ProgressViewExample: View {
    @State private var progress = 0.5
    @State private var donwloadDes = "下载中..."
    @State private var downloadProgress:Double = 0.0
    private let total = 100.0
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ProgressView("loading")
                .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
            VStack(alignment: .leading) {
                ProgressView("value:\(progress)", value: progress, total: 1)
                    .accentColor(.red)
                    .foregroundColor(.yellow)
                HStack{
                    Button("More", action: { progress += 0.05 })
                    Button("Less", action: { progress -= 0.05 })
                }
            }
            VStack {
                ProgressView("\(progress)", value: progress, total: 1)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
            }
            HStack {
                Spacer(minLength: 40)
                let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                ProgressView(donwloadDes, value: downloadProgress, total: total)
                    .onReceive(timer, perform: { _ in
                        if (downloadProgress < total) {
                            downloadProgress += 2.0
                            if (downloadProgress >= total) {
                                downloadProgress = total
                                donwloadDes = "下载完毕"
                            }
                        }
                    })
                Spacer(minLength: 40)
            }
            Spacer()
        }.padding(20)
    }
}

private struct StepperExample: View {
    @State var value = 20
    @State var value2 = 100
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Stepper(value: $value, in: 0...100, label: {
                    Text("value: \(value)")
                }, onEditingChanged: { changed in
                    if changed {
                        print("from: \(self.value)")
                    } else {
                        print("to: \(self.value)")
                    }
                })
                Spacer()
            }
            HStack {
                Stepper(label: {
                    Text("value2: \(self.value2)")
                }, onIncrement: {
                    self.value2 += 10
                }, onDecrement: {
                    self.value2 -= 10
                })
            }
            Spacer()
        }.padding(20)
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
        // https://docs.microsoft.com/en-us/openspecs/office_standards/ms-oe376/6c085406-a698-4e12-9d4d-c3b0ee3dbc4a
        BasicsElement(name: "Button")
            .environment(\.locale, Locale(identifier: "zh-CN"))
        
    }
}
