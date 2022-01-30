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
        case "GeometryEffect":
            GeometryEffectExample()
        case "AnimatableModifier":
            AnimatableModifierExample()
        case "TimelineView":
            TimelineViewExample()
        case "Canvas":
            CanvasExample()
        case "SwiftUI-Lab":
            LabExample()
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
            
            for i in (n+2)..<min(n + (vertex.count-1), vertex.count) {
                path.move(to: vertex[n])
                path.addLine(to: vertex[i])
            }
            
            drawVertexLines(path: &path, vertex: vertex, n: n+1)
        }
    }
    
}

struct GeometryEffectExample: View {
    var body: some View {
        Text("GeometryEffectExample")
//            .modifier(SkewEfect(skewValue: 0.5))
    }
}

struct AnimatableModifierExample: View {
    var body: some View {
        Text("AnimatableModifierExample")
    }
}

struct TimelineViewExample: View {
    var body: some View {
        Text("AnimatableModifierExample")
    }
}

struct CanvasExample: View {
    var body: some View {
        Text("AnimatableModifierExample")
    }
}

struct AnimateExample_Previews: PreviewProvider {
    static var previews: some View {
        AnimateExample(name: "GeometryEffect")
    }
}
