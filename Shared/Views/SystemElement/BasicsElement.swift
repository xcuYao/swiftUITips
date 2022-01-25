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
        #if os(macOS)
        VStack {
            contentView(name: name)
        }
        #else
        VStack {
           contentView(name: name)
        }.background(Color(hex: "#F2F2F7")).navigationBarTitle(Text(name), displayMode: .inline)
        #endif
        
    }
    
    struct contentView: View {
        var name: String
        var body: some View {
            switch name {
            case "Text":
                ScrollView {
                    TextExample()
                }
            case "Button":
                ScrollView {
                    ButtonExample()
                }
            case "Image":
                ScrollView {
                    ImageExample()
                }
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
                ScrollView {
                    DatePickerExample()
                }
            case "ProgressView":
                ProgressViewExample()
            case "Stepper":
                StepperExample()
            default:
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
        }
    }
    
}

struct BasicsElement_Previews: PreviewProvider {
    static var previews: some View {
        // https://docs.microsoft.com/en-us/openspecs/office_standards/ms-oe376/6c085406-a698-4e12-9d4d-c3b0ee3dbc4a
        BasicsElement(name: "DatePicker")
            .environment(\.locale, Locale(identifier: "zh-CN"))

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
            VStack(spacing: 10) {
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
                VStack(alignment: .leading, spacing: 10) {
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
        }.cornerRadius(6)
    }

    func tapHandler() {
        actionText = "点我干哈？\(Int.random(in: 0...999))"
    }
}

private struct ButtonExample: View {
    @State private var showAlert = false
    var body: some View {

        VStack(alignment: .leading, spacing: 20) {
            // 初始化方式1
            HStack {
                Button(action: {
                    showAlert = !showAlert
                }) {
                    Text("JustButton").padding(20)
                }
                Spacer()
            }
            // 初始化方式2
            Button("自定义样式") {
                showAlert = !showAlert
            }.buttonStyle(customButtonStyle(color: .green))
            //
            Button(action: {
                showAlert = !showAlert
            }) {
                Text("简单样式").foregroundColor(.white)
            }.padding(10)
                .buttonStyle(.plain)
                .background(.red)
                .cornerRadius(6)
            //
            Button("长按1s试试") {
                showAlert = !showAlert
            }.buttonStyle(customButtonStyle2(color: .green))
            Spacer()
        }.padding(20)
            .alert(isPresented: $showAlert) {
            Alert(title: Text("提示信息"), message: Text("无聊的信息"), dismissButton: .default(Text("👌")))
        }
    }

    struct customButtonStyle: ButtonStyle {
        var color: Color = .blue
        func makeBody(configuration: Configuration) -> some View {
            configuration.label.foregroundColor(.white)
                .padding(20)
                .background(RoundedRectangle(cornerRadius: 6).fill(color))
                .compositingGroup()
                .shadow(color: .yellow, radius: 6)
                .opacity(configuration.isPressed ? 0.5 : 1.0)
                .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
        }
    }

    struct customButtonStyle2: PrimitiveButtonStyle {
        var color: Color = .blue
        func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
            LongPressButton(configuration: configuration, color: color)
        }
        struct LongPressButton: View {
            let configuration: PrimitiveButtonStyle.Configuration
            let color: Color
            @GestureState private var pressed = false
            var body: some View {
                let longPress = LongPressGesture(minimumDuration: 1.0, maximumDistance: 0.0)
                    .updating($pressed) { value, state, _ in
                    state = value
                }.onEnded { _ in
                    self.configuration.trigger()
                }
                return configuration.label
                    .foregroundColor(.white)
                    .padding(20)
                    .background(RoundedRectangle(cornerRadius: 6).fill(color))
                    .compositingGroup()
                    .shadow(color: .black, radius: 6, x: 4, y: 4)
                    .opacity(pressed ? 0.5 : 1.0)
                    .scaleEffect(pressed ? 0.8 : 1.0)
                    .gesture(longPress)
            }
        }
    }

}

private struct ImageExample: View {
    // 1. 修改图片尺寸 先resizable后调整frame 才会改变图片大小
    // 调用顺序会导致某些方法调不到 因为点语法每次返回的都是一个新的struct
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image("swiftui")
                Spacer()
            }
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
                    .clipped()
                Text("120*40 scaledToFit")
            }
            VStack {
                Image("swiftui")
                    .resizable()
                    .aspectRatio(20, contentMode: .fill)
                    .frame(width: 120, height: 40)
                    .fixedSize(horizontal: true, vertical: false)
                    .clipped()
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
        }.padding(20)
    }
}

private struct ToggleExample: View {

    @State var isOn = true
    @State var flipped = false
    
    private var outPadding: Double {
        #if os(macOS)
        return 10
        #else
        return -10
        #endif
    }
    
    var body: some View {
        Form {
            HStack {
                Text("Default Toggle:")
                Toggle(isOn: $isOn) {
                    Text("Toggle Test")
                }
                Spacer()
            }
            HStack {
                Text("Custom Toggle:")
                Toggle("Toggle Me", isOn: $isOn)
                    .toggleStyle(CustomToggleStyle())
            }
            HStack {
                Toggle(isOn: $isOn, label: {
                    Image(systemName: "arkit")
                    Text("是否开启:")
                }).toggleStyle(CustomToggleStyle2())
            }
            HStack {
                Toggle(isOn: $isOn) {
                    VStack {
                        Group {
                            Image(systemName: flipped ? "folder.fill" : "map.fill")
                            Text(flipped ? "地图" : "列表")
                        }.rotation3DEffect(flipped ? .degrees(180) : .degrees(0), axis: (x: 0, y: 1, z: 0))
                    }
                }.toggleStyle(CustomToggleStyle3(flipped: $flipped))
            }
        }.padding(self.outPadding)
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

    struct CustomToggleStyle2: ToggleStyle {
        let width: CGFloat = 50
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                configuration.label
                ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: width, height: width / 2.0)
                        .foregroundColor(configuration.isOn ? .green : .red)
                        .onTapGesture {
                        withAnimation {
                            configuration.$isOn.wrappedValue.toggle()
                        }
                    }
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: (width / 2) - 4, height: (width / 2) - 6)
                        .padding(4)
                        .foregroundColor(.white)
                        .allowsHitTesting(false)
                }
            }
        }
    }

    struct CustomToggleStyle3: ToggleStyle {

        let width: CGFloat = 50
        let height: CGFloat = 60
        @Binding var flipped: Bool

        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .frame(width: width, height: height)
                .modifier(FlipEffect(flipped: $flipped, angle: configuration.isOn ? 180 : 0))
                .onTapGesture {
                withAnimation {
                    configuration.$isOn.wrappedValue.toggle()
                }
            }
        }
    }

    struct FlipEffect: GeometryEffect {
        @Binding var flipped: Bool
        var angle: Double
        var animatableData: Double {
            get { angle }
            set { angle = newValue }
        }
        func effectValue(size: CGSize) -> ProjectionTransform {
            DispatchQueue.main.async {
                self.flipped = (self.angle >= 90 && self.angle >= 180)
            }
            let a = CGFloat(Angle.degrees(angle).radians)
            var transform3d = CATransform3DIdentity
            transform3d.m34 = -1 / max(size.width, size.height)
            transform3d = CATransform3DRotate(transform3d, a, 0, 1, 0)
            transform3d = CATransform3DTranslate(transform3d, -size.width / 2.0, -size.height / 2.0, 0)
            let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width / 2.0, y: size.height / 2.0))
            return ProjectionTransform(transform3d).concatenating(affineTransform)
        }
    }

}

private struct LabelExample: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label("SwiftUI", image: "swiftui")
                Spacer()
            }
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
            Spacer()
        }.padding(20)
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

private struct SliderExample: View {

    @State var value: Double = 5
    var body: some View {
        VStack(alignment: .center) {
            VStack {
                Text("Slider Value: \(value)")
                Slider(value: $value, in: 0...10)
                    .frame(width: 200, height: 20, alignment: .top)
            }.padding(20)
            Divider()
            VStack {
                Text("Step Value: \(value)")
                Slider(value: $value, in: 0...10, step: 1.0) {
                    Text("标题:")
                } onEditingChanged: { bool in
                    let str = bool ? "开始" : "结束"
                    print("状态:\(str)")
                }.frame(width: 300, height: 20, alignment: .leading)
            }.padding(20)
            Divider()
            VStack {
                Text("Max Min Value: \(value)")
                Slider(value: $value, in: -100...100, label: { EmptyView() }, minimumValueLabel: { Text("-100") }, maximumValueLabel: { Text("100") })
            }.padding(20)
            Spacer(minLength: 20)
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
//                .background(VisualEffectView())
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
        }.padding(20)
    }
//    struct VisualEffectView: NSViewRepresentable {
//        func makeNSView(context: Context) -> NSVisualEffectView {
//            let view = NSVisualEffectView()
//            view.blendingMode = .behindWindow // << important !!
//            view.isEmphasized = true
//            view.material = .titlebar
//            return view
//        }
//
//        func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
//        }
//    }

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
        endDate = beginDate.addingTimeInterval(60 * 60 * 24 * 365)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack {
                Text("\(selection)")
                DatePicker("date", selection: $selection, in: beginDate...endDate, displayedComponents: .date)
                DatePicker("hourAndMinute", selection: $selection, in: beginDate...endDate, displayedComponents: .hourAndMinute)
            }.padding(20)
            Divider()
            HStack {
                DatePicker(selection: $selection, label: {
                    Image(systemName: "airplane")
                    Text("compact Style")
                })
            }
            Divider()
            #if os(macOS)
            DatePicker(selection: $selection, label: {
                Image(systemName: "airplane")
                Text("field Style")
            }).datePickerStyle(.field)
            #else
            DatePicker(selection: $selection, label: {
                Image(systemName: "airplane")
                Text("field Style")
            })
            #endif
            Divider()
            DatePicker(selection: $selection, label: {
                Image(systemName: "airplane")
                Text("graphical Style")
            }).datePickerStyle(.graphical)
            Divider()
            #if os(macOS)
            DatePicker(selection: $selection, label: {
                Image(systemName: "airplane")
                Text("graphical Style")
            }).datePickerStyle(.stepperField)
            #else
            DatePicker(selection: $selection, label: {
                Image(systemName: "airplane")
                Text("graphical Style")
            })
            #endif
        }

    }
}

private struct ProgressViewExample: View {
    @State private var progress = 0.5
    @State private var donwloadDes = "下载中..."
    @State private var downloadProgress: Double = 0.0
    private let total = 100.0
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ProgressView("loading")
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                VStack(alignment: .leading) {
                    ProgressView("value:\(progress)", value: progress, total: 1)
                        .accentColor(.red)
                        .foregroundColor(.yellow)
                    HStack {
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
                HStack {
                    CustomProgressView(progress: progress).frame(width: 300, height: 100, alignment: .center)
                }
                VStack {
                    CustomProgressView2(progress)
                        .frame(width: 200, height: 200, alignment: .center)

                    Slider(value: self.$progress, in: 0...1)
                        .padding(.horizontal, 30)

                    HStack {
                        Group {
                            Button("20%") {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.progress = 0.2
                                }
                            }.foregroundColor(Color.black)
                            Button("50%") {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.progress = 0.5
                                }
                            }.foregroundColor(Color.black)
                            Button("80%") {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.progress = 0.8
                                }
                            }.foregroundColor(Color.black)
                        }
                            .foregroundColor(.white)
                            .padding(.all, 10)
                            .background(RoundedRectangle(cornerRadius: 5.0).foregroundColor(.green))
                    }
                }
                Spacer()
            }.padding(20)
        }
    }


    struct CustomProgressView: View {
        let gradient = Gradient(colors: [.blue, .green])
        let scliceSize = 0.45
        let progress: Double

        private let percentageFormatter: NumberFormatter = {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .percent
            return numberFormatter
        }()

        var stockGradient: AngularGradient {
            AngularGradient(gradient: gradient, center: .center, angle: .degrees(-10))
        }
        var rotateAngle: Angle {
                .degrees(90 + scliceSize * 360 * 0.5)
        }

        func stockStyle(_ proxy: GeometryProxy) -> StrokeStyle {
            StrokeStyle(lineWidth: 0.1 * min(proxy.size.width, proxy.size.height), lineCap: .round)
        }

        var body: some View {
            GeometryReader { proxy in
                HStack {
                    VStack {
                        Circle()
                            .trim(from: 0, to: 1 - CGFloat(scliceSize))
                            .stroke(self.stockGradient, style: self.stockStyle(proxy))
                            .padding(.all, 10)
                            .rotationEffect(self.rotateAngle, anchor: .center)
                            .offset(x: 0, y: 0.1 * min(proxy.size.width, proxy.size.height))
                        Text("背景").font(.title).bold()
                    }
                    VStack {
                        Circle()
                            .trim(from: 0, to: CGFloat(self.progress * (1 - self.scliceSize)))
                            .stroke(Color.purple, style: self.stockStyle(proxy))
                            .padding(.all, 10)
                            .rotationEffect(self.rotateAngle, anchor: .center)
                            .offset(x: 0, y: 0.1 * min(proxy.size.width, proxy.size.height))
                        Text("当前进度").font(.title).bold()
                    }
                    Text("\(self.percentageFormatter.string(from: NSNumber(value: self.progress))!)")
                        .font(.largeTitle)
                        .bold()
                }
            }
        }
    }

    struct CustomProgressView2: View {
        let gradient = Gradient(colors: [.green, .blue])
        let sliceSize = 0.45
        let progress: Double

        private let percentageFormatter: NumberFormatter = {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .percent
            return numberFormatter
        }()

        var strokeGradient: AngularGradient {
            AngularGradient(gradient: gradient, center: .center, angle: .degrees(-10))
        }

        var rotateAngle: Angle {
                .degrees(90 + sliceSize * 360 * 0.5)
        }

        init(_ progress: Double = 0.3) {
            self.progress = progress
        }

        private func strokeStyle(_ proxy: GeometryProxy) -> StrokeStyle {
            StrokeStyle(lineWidth: 0.1 * min(proxy.size.width, proxy.size.height),
                        lineCap: .round)
        }

        public var body: some View {
            GeometryReader { proxy in
                ZStack {
                    Group {
                        Circle()
                            .trim(from: 0, to: 1 - CGFloat(self.sliceSize))
                            .stroke(self.strokeGradient,
                                    style: self.strokeStyle(proxy))
                            .padding(.all, 10)

                        Circle()
                            .trim(from: 0, to: CGFloat(self.progress * (1 - self.sliceSize)))
                            .stroke(Color.purple,
                                    style: self.strokeStyle(proxy))
                            .padding(.all, 10)
                    }
                        .rotationEffect(self.rotateAngle, anchor: .center)
                        .offset(x: 0, y: 0.1 * min(proxy.size.width, proxy.size.height))

                    Text("\(self.percentageFormatter.string(from: NSNumber(value: self.progress))!)")
                        .font(.largeTitle)
                        .bold()
                }
            }
        }
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
#if os(macOS)
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}
#endif

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
