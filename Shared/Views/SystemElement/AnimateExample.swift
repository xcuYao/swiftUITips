//
//  AnimateExample.swift
//  SwiftUITip
//  https://swiftui-lab.com/category/animations/ 学习
//  Created by yaoning on 2022/1/30.
//

import SwiftUI

struct AnimateExample: View {

    var name: String

    var body: some View {
        switch name {
        case "Paths":
            PathsExample()
        case "SwiftUI-Lab":
            LabExample()
        case "Transitions":
            TransitionsExample()
        case "3D-Scroll":
            ThreeDScrollExample()
        default:
            Text("AnimateExample")
        }
    }
}

struct PathsExample: View {

    @State private var half = false
    @State private var dim = false

    @State private var sides = 3
    @State private var scale = 1.0

    @State private var coolSides = 12
    @State private var coolScale = 1.0

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center) {
                Text("显示动画Explicit && 隐式动画Implicit").font(.system(size: 14)).padding(.leading, 10)
                Image("airpods")
                    .scaleEffect(half ? 0.5 : 1.0)
                    .opacity(dim ? 0.2 : 1.0)
                // 隐式声明
                //                .animation(.easeInOut(duration: 1.0), value: half)
                //                .animation(.easeInOut(duration: 1.0), value: dim)
                .onTapGesture {
                    //                    self.half.toggle()
                    //                    self.dim.toggle()
                    // 显式调用
                    withAnimation(.easeOut(duration: 1.0)) {
                        self.half.toggle()
                        self.dim.toggle()
                    }
                }
                Divider()
                Text("多边形绘制").font(.system(size: 14)).padding([.leading, .top], 10)
                PolygonShape(sides: sides, scale: scale)
                    .stroke(Color.blue, lineWidth: 3)
                    .frame(minWidth: 200, minHeight: 200)
                    .animation(.easeInOut(duration: 1.0), value: sides)
                    .animation(.easeInOut(duration: 1.0), value: scale)
                HStack {
                    TipButton(label: "6", action: {
                        self.sides = 6
                        self.scale = 0.5
                    })
                    TipButton(label: "10", action: {
                        self.sides = 10
                        self.scale = 1.0
                    })
                    TipButton(label: "12", action: {
                        self.sides = 12
                        self.scale = 1.5
                    })
                    TipButton(label: "16", action: {
                        self.sides = 16
                        self.scale = 2.0
                    })
                }
                Divider()
                Text("酷炫多边形绘制").font(.system(size: 14)).padding([.leading, .top], 10)
                CoolPolygonShape(sides: Double(coolSides), scale: coolScale)
                    .stroke(Color.blue, lineWidth: 3)
                    .frame(minWidth: 200, minHeight: 200)
                    .animation(.easeInOut(duration: 1.0), value: coolSides)
                    .animation(.easeInOut(duration: 1.0), value: coolScale)
                HStack {
                    TipButton(label: "1", action: {
                        self.coolSides = 1
                        self.coolScale = 0.5
                    })
                    TipButton(label: "10", action: {
                        self.coolSides = 10
                        self.coolScale = 1.0
                    })
                    TipButton(label: "12", action: {
                        self.coolSides = 12
                        self.coolScale = 1.5
                    })
                    TipButton(label: "16", action: {
                        self.coolSides = 16
                        self.coolScale = 2.0
                    })
                }
            }
        }
    }

    struct PolygonShape: Shape {

        var sides: Int
        var scale: Double
        private var sidesAsDouble: Double

        var animatableData: AnimatablePair<Double, Double> {
            get { return AnimatablePair(sidesAsDouble, scale) }
            set {
                sidesAsDouble = newValue.first
                scale = newValue.second
            }
        }

        init(sides: Int, scale: Double) {
            self.sides = sides
            self.scale = scale
            self.sidesAsDouble = Double(sides)
        }

        func path(in rect: CGRect) -> Path {
            // 高度
            let h = Double(min(rect.size.width, rect.size.height)) / 2.0 * scale
            // 中心点
            let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
            //
            let extra: Int = Double(sidesAsDouble) != Double(sidesAsDouble) ? 1 : 0
            var path = Path()
            // 找到各个点的位置 然后画线
            for i in 0..<Int(sidesAsDouble) + extra {
                // 计算旋转角度
                let angle = (Double(i) * (360.0 / sidesAsDouble)) * Double.pi / 180
                // 找到顶点 利用三角函数 sin cos
                let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
                if i == 0 {
                    path.move(to: pt)
                } else {
                    path.addLine(to: pt)
                }
            }
            path.closeSubpath()
            return path
        }
    }

    struct CoolPolygonShape: Shape {
        var sides: Double
        var scale: Double

        var animatableData: AnimatablePair<Double, Double> {
            get { AnimatablePair(sides, scale) }
            set {
                sides = newValue.first
                scale = newValue.second
            }
        }

        func path(in rect: CGRect) -> Path {
            // hypotenuse
            let h = Double(min(rect.size.width, rect.size.height)) / 2.0 * scale

            // center
            let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)

            var path = Path()

            let extra: Int = sides != Double(Int(sides)) ? 1 : 0

            var vertex: [CGPoint] = []

            for i in 0..<Int(sides) + extra {

                let angle = (Double(i) * (360.0 / sides)) * (Double.pi / 180)

                // Calculate vertex
                let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))

                vertex.append(pt)

                if i == 0 {
                    path.move(to: pt) // move to first vertex
                } else {
                    path.addLine(to: pt) // draw line to next vertex
                }
            }

            path.closeSubpath()

            // Draw vertex-to-vertex lines
            drawVertexLines(path: &path, vertex: vertex, n: 0)

            return path
        }

        func drawVertexLines(path: inout Path, vertex: [CGPoint], n: Int) {

            if (vertex.count - n) < 3 { return }

            for i in (n + 2)..<min(n + (vertex.count - 1), vertex.count) {
                path.move(to: vertex[n])
                path.addLine(to: vertex[i])
            }

            drawVertexLines(path: &path, vertex: vertex, n: n + 1)
        }
    }

}

struct TransitionsExample: View {
    var body: some View {
        List {
            NavigationLink(destination: {
                TransitionsExample1()
            }, label: {
                    Text("Asymmetrical Transitions")
                })
        }
    }
}

struct TransitionsExample1: View {

    struct LabelView: View {
        var body: some View {
            Text("Hello world")
                .padding(10)
                .font(.title)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.green))
        }
    }

    @State var show: Bool = false
    @State private var selectTransition = "opacity"
    private var transitions = ["opacity", "asymmetric", "asymmetric combined", "flyTransition"]
    func fetchTransition() -> AnyTransition {
        switch selectTransition {
        case "opacity":
            // 对称动画 透明度
            return .opacity
        case "asymmetric":
            // 不对称动画 入:透明度 出:缩放
            return .asymmetric(insertion: .opacity, removal: .scale)
        case "asymmetric combined":
            // 组合过渡
            return .asymmetric(insertion: AnyTransition.opacity.combined(with: .slide), removal: .scale)
        case "flyTransition":
            return .fly
        default:
            return .opacity
        }
    }

    var body: some View {
        VStack(spacing: 10) {
            Picker(selection: $selectTransition, content: {
                ForEach(transitions, id: \.self) {
                    Text($0)
                }
            }, label: {
                    Text("动画效果:\(selectTransition)")
                })
            Button(action: {
                withAnimation {
                    show.toggle()
                }
            }, label: {
                    Text("animate")
                }).padding(20)
            if show {
                LabelView()
                    .transition(self.fetchTransition())
            }
        }
    }
}

struct ThreeDScrollExample: View {

    @State var colors: [Color] = Array(0...10).map { _ in Color.random }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 230) {
                ForEach(colors, id: \.self) { color in
                    GeometryReader { geometry in
                        Rectangle().foregroundColor(color)
                            .frame(width: 200, height: 300, alignment: .center)
                            .cornerRadius(16)
                            .rotation3DEffect(Angle(degrees: (Double(geometry.frame(in: .global).minX) - 210) / -20), axis: (x: 0, y: 1.0, z: 0))
                    }
                }
            }.padding(.horizontal, 210)
        }
    }
}

extension AnyTransition {
    static var fly: AnyTransition {
        get {
            AnyTransition.modifier(active: FlyTransition(pct: 0), identity: FlyTransition(pct: 1))
        }
    }

    struct FlyTransition: GeometryEffect {
        var pct: Double

        var animatableData: Double {
            get { pct }
            set { pct = newValue }
        }

        func effectValue(size: CGSize) -> ProjectionTransform {

            let rotationPercent = pct
            let a = CGFloat(Angle(degrees: 90 * (1 - rotationPercent)).radians)

            var transform3d = CATransform3DIdentity;
            transform3d.m34 = -1 / max(size.width, size.height)

            transform3d = CATransform3DRotate(transform3d, a, 1, 0, 0)
            transform3d = CATransform3DTranslate(transform3d, -size.width / 2.0, -size.height / 2.0, 0)

            let affineTransform1 = ProjectionTransform(CGAffineTransform(translationX: size.width / 2.0, y: size.height / 2.0))
            let affineTransform2 = ProjectionTransform(CGAffineTransform(scaleX: CGFloat(pct * 2), y: CGFloat(pct * 2)))

            if pct <= 0.5 {
                return ProjectionTransform(transform3d).concatenating(affineTransform2).concatenating(affineTransform1)
            } else {
                return ProjectionTransform(transform3d).concatenating(affineTransform1)
            }
        }
    }
}

struct AnimateExample_Previews: PreviewProvider {
    static var previews: some View {
        AnimateExample(name: "GeometryEffect")
    }
}
