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
            DropdownPicker(title: "Size",options: ["Small", "Medium", "Large", "X-Large"], selection: $sizeSelection)
            Divider().padding([.horizontal], 12)
            DropdownPicker(title: "Name",options: ["Andy", "Bob", "Jack", "Zheng"], selection: $nameSelection)
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

struct TutorialsExample_Previews: PreviewProvider {
    static var previews: some View {
        TutorialsExample(name: "DropdownPicker")
    }
}
