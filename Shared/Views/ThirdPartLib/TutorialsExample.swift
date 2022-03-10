//
//  TutorialsExample.swift
//  SwiftUITip (iOS)
//
//  Created by yaoning on 2022/2/28.
//

import SwiftUI

struct TutorialsExample: View {

    var name: String

    var body: some View {
        switch name {
        case "DropdownPicker":
            DropdownPickerExample()
        case "IsometricView":
            IsometricViewExample()
        case "Shadows&&Glows":
            ShadowsAndGlowsExample()
        default:
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct DropdownPickerExample: View {

    @State private var sizeSelection = 0
    @State private var nameSelection = 0

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            DropdownPicker(title: "Size", options: ["Small", "Medium", "Large", "X-Large"], selection: $sizeSelection)
            Divider().padding([.horizontal], 12)
            DropdownPicker(title: "Name", options: ["Andy", "Bob", "Jack", "Zheng"], selection: $nameSelection)
        }
    }
}

struct DropdownPicker: View {
    var title: String
    var options: [String]
    @Binding var selection: Int
    @State private var showOptions: Bool = false

    var body: some View {
        ZStack {
            HStack {
                Text(title)
                Spacer()
                Text(options[selection])
                    .foregroundColor(Color.black.opacity(0.6))
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
            }.font(Font.custom("Avenir Next", size: 16).weight(.medium))
                .padding([.horizontal], 12)
                .padding([.vertical], 8)
                .background(Color.white)
                .onTapGesture {
                withAnimation(Animation.spring().speed(2)) {
                    showOptions.toggle()
                }
            }
            if showOptions {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Size")
                        .font(Font.custom("Avenir Next", size: 16).weight(.semibold))
                        .foregroundColor(.white)
                    HStack {
                        Spacer()
                        ForEach(options.indices, id: \.self) { i in
                            if i == selection {
                                Text(options[i])
                                    .picker_selectionStyle()
                                    .onTapGesture {
                                    withAnimation(Animation.spring().speed(2)) {
                                        showOptions.toggle()
                                    }
                                }.frame(maxWidth: .infinity)
                            } else {
                                Text(options[i])
                                    .picker_normalStyle()
                                    .onTapGesture {
                                    withAnimation(Animation.spring().speed(2)) {
                                        selection = i
                                        showOptions.toggle()
                                    }
                                }.frame(maxWidth: .infinity)
                            }
                        }
                        Spacer()
                    }.padding([.vertical], 2)
                        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                }.padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .transition(.opacity)
            }
        }
    }
}

extension Text {
    func picker_selectionStyle() -> some View {
        self.font(.system(size: 12))
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color.white.opacity(0.2))
            .cornerRadius(4)
    }
    func picker_normalStyle() -> some View {
        self.font(.system(size: 12))
    }
}

// ----------------

struct IsometricViewExample: View {
    @State private var active = false
    var body: some View {
        VStack {
            IsometricView(active: active, extruded: true, depth: 20) {
                Rectangle()
                    .fill(LinearGradient(colors: [.red, .green, .blue], startPoint: .leading, endPoint: .trailing))
                    .frame(width: 100, height: 100)
            }
            Toggle("active", isOn: $active.animation())
                .frame(width: 200, alignment: .center)
        }
    }
}

struct IsometricView<Content: View>: View {

    var active: Bool
    var content: Content
    var extruded: Bool
    var depth: CGFloat

    init(active: Bool, extruded: Bool = false, depth: CGFloat = 20, @ViewBuilder content: () -> Content) {
        self.active = active
        self.extruded = extruded
        self.depth = depth
        self.content = content()
    }

    @ViewBuilder var body: some View {
        if active {
            if extruded {
                content
                    .modifier(ExtrudeModifier(depth: depth, texture: content))
                    .modifier(IsometricViewModifier(active: active))
                    .animation(.easeInOut, value: active)
            } else {
                content
                    .modifier(IsometricViewModifier(active: active))
                    .animation(.easeInOut, value: active)
            }
        } else {
            content
                .animation(.easeInOut, value: active)
        }
    }
}

struct IsometricViewModifier: ViewModifier {
    var active: Bool
    func body(content: Content) -> some View {
        if active {
            content
                .rotationEffect(Angle(degrees: 45), anchor: .center)
                .scaleEffect(x: 1.0, y: 0.5, anchor: .center)
        } else {
            content
        }
    }
}

struct ExtrudeModifier<Texture: View>: ViewModifier {
    var depth: CGFloat
    var texture: Texture
    func body(content: Content) -> some View {
        content
            .overlay(
            GeometryReader { geo in
                texture
                    .brightness(-0.05)
                    .scaleEffect(x: 1, y: geo.size.height * geo.size.height, anchor: .bottom)
                    .frame(height: depth, alignment: .top)
                    .mask(Rectangle())
                    .rotation3DEffect(Angle(degrees: 180),
                    axis: (x: 1.0, y: 0.0, z: 0.0),
                    anchor: .center,
                    anchorZ: 0.0,
                    perspective: 1.0
                )
                    .projectionEffect(ProjectionTransform(CGAffineTransform(a: 1, b: 0, c: 1, d: 1, tx: 0, ty: 0)))
                    .offset(x: 0, y: geo.size.height)
            }, alignment: .center)
            .overlay(
            GeometryReader { geo in
                texture
                    .brightness(-0.1)
                    .scaleEffect(x: geo.size.width * geo.size.width, y: 1.0, anchor: .trailing)
                    .frame(width: depth, alignment: .leading)
                    .clipped()
                    .rotation3DEffect(
                    Angle(degrees: 180),
                    axis: (x: 0.0, y: 1.0, z: 0.0),
                    anchor: .leading,
                    anchorZ: 0.0,
                    perspective: 1.0
                )
                    .projectionEffect(ProjectionTransform(CGAffineTransform(a: 1, b: 1, c: 0, d: 1, tx: 0, ty: 0)))
                    .offset(x: geo.size.width + depth, y: 0 + depth)
            }, alignment: .center)
    }
}

extension View {
    func multicolorGlow() -> some View {
        ForEach(0..<2) { i in
            Rectangle()
                .fill(AngularGradient(gradient: Gradient(colors: [.red, .green, .blue, .yellow, Color(hex: "#ff3300"), .red]), center: .center))
                .frame(width: 400, height: 400)
                .mask(self.blur(radius: 20))
                .overlay(self.blur(radius: 5 - CGFloat(i * 5)))
        }
    }

    func innerShadow<S: Shape>(using shape: S, angel: Angle = .degrees(0), color: Color = .black, width: CGFloat = 6, blur: CGFloat = 6) -> some View {
        let finalX = CGFloat(cos(angel.radians - .pi / 2))
        let finalY = CGFloat(sin(angel.radians - .pi / 2))

        return self
            .overlay(
            shape
                .stroke(color, lineWidth: width)
                .offset(x: finalX * width * 0.6, y: finalY * width * 0.6)
                .blur(radius: blur)
                .mask(shape)
        )
    }
}

struct ShadowsAndGlowsExample: View {
    var body: some View {
            ScrollView(.vertical) {
                ZStack {
                    Text("Hello SwiftUI")
                        .font(.system(size: 96, weight: .black, design: .rounded))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 400, height: 400)
                        .multicolorGlow()
                }
//                .frame(width: 400, height: 400)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black)
                HStack {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 300, height: 300)
                        .innerShadow(using: Circle())
                }.frame(maxWidth: .infinity)
                    .background(Color.white)
            }
            .edgesIgnoringSafeArea(.all)
    }
}

struct TutorialsExample_Previews: PreviewProvider {
    static var previews: some View {
        TutorialsExample(name: "Shadows&&Glows")
    }
}
