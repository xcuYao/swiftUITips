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
            HStack(spacing: 10){
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
        VStack{
            // 初始化方式1
            Button(action: {
                print("click 1")
            }) {
                Text("JustButton")
            }
            // 初始化方式2
            Button("JustButton"){
                print("click 2")
            }
            //
            Button(action: {}) {
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
            VStack{
                Image("swiftui")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 40)
                    .background(Color.brown)
                Text("120*40 scaledToFit")
            }
            VStack{
                Image("swiftui")
                    .resizable()
                    .aspectRatio(20, contentMode: .fill)
                    .frame(width: 120, height: 40)
                    .fixedSize(horizontal: true, vertical: false)
                Text("120*40 scaledToFill")
            }
            VStack{
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
            Section{
                Toggle(isOn: $isOn) {
                    Text("Toggle Test")
                }
            }
        }
    }
}

struct BasicsElement_Previews: PreviewProvider {
    static var previews: some View {
        BasicsElement(name: "Toggle")
    }
}
