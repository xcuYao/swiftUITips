//
//  LayoutElement.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/22.
//

import SwiftUI

struct LayoutElement: View {

    var name: String = "HStack"
    var body: some View {
        VStack {
            switch name {
            case "NavigationView":
                NavigationExample()
            case "TabView":
                TabViewExample()
            case "HStack/VStack/ZStack":
                StackExample()
            case "LazyStack":
                LazyStackExample()
            case "List":
                ListExample()
            case "ScrollView":
                ScrollViewExample()
            case "Grid":
                GridExample()
            default:
                Text("Default")
            }
        }.background(Color(hex: "#F2F2F7")).navigationBarTitle(Text(name), displayMode: .inline)
    }
}

struct LayoutElement_Previews: PreviewProvider {
    static var previews: some View {
        LayoutElement(name: "Grid")
    }
}

struct NavigationExample: View {
    @State private var presented = false
    var body: some View {
        Button("presented") {
            self.presented = true
        }.fullScreenCover(isPresented: self.$presented, onDismiss: {
            print("Dismiss")
        }, content: {
            NavigationView {
                PresentedView(index: 1)
            }
        })
    }

    struct PresentedView: View {

        var index: Int = 0
        @State private var isActive = false

        @Environment(\.presentationMode) var presentationMode

        var body: some View {
            NavigationLink(isActive: $isActive, destination: {
                PresentedView(index: index + 1, presentationMode: _presentationMode)
            }, label: {
                Text("click Me")
                    .navigationTitle("Page\(index)")
                    .navigationBarItems(trailing: dismissButton())
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                            self.isActive = !self.isActive
//                        }
//                    }
            })
        }

        func dismissButton() -> some View {
            Button("dismiss") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct TabViewExample: View {

    @State private var selection: Int = 0

    var body: some View {
        TabView(selection: $selection) {
            TabContentView(name: "Tab1")
                .tabItem {
                Image(systemName: "car")
                Text("Tab1")
            }.tag(0)
            TabContentView(name: "Tab2")
                .tabItem {
                Image(systemName: "photo")
                Text("Tab2")
            }.tag(1)
            TabContentView(name: "Tab3")
                .tabItem {
                Image(systemName: "sun.min")
                Text("Tab3")
            }.tag(2)
            TabContentView(name: "Tab4")
                .tabItem {
                Image(systemName: "person.fill")
                Text("Tab4")
            }.tag(3)
            TabContentView(name: "Tab5")
                .tabItem {
                Image(systemName: "globe.asia.australia")
                Text("Tab5")
            }.tag(4)
            TabContentView(name: "Tab6")
                .tabItem {
                Image(systemName: "drop")
                Text("Tab6")
            }.tag(5)
        }
    }
    struct TabContentView: View {
        var name: String
        var body: some View {
            Text(name)
        }
    }
}

struct StackExample: View {
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Spacer()
                }
                HStack {
                    Text("header").foregroundColor(.white).frame(alignment: .center)
                }
            }.frame(height: 100).background(.blue)
            HStack(alignment: .top, spacing: 10) {
                ZStack(alignment: .center) {
                    VStack {
                        Spacer()
                        Spacer()
                    }
                    Text("left-nav").foregroundColor(.white)
                }.frame(width: 80).background(.yellow).padding(.leading, 10)
                VStack(alignment: .center, spacing: 10) {
                    ScrollView {
                        ForEach(0..<100) { i in
                            HStack {
                                Text("\(i)").foregroundColor(.black).frame(width: 100, height: 40).background(.white)
                                Spacer()
                            }.background(.random)
                        }
                    }
                }.frame(alignment: .topLeading).border(.black)
            }
            Spacer()
        }.background(.red)
    }
}

struct LazyStackExample: View {
    var body: some View {
        VStack {
            Text("1w条数据")
            HStack(alignment: .top) {
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0...10000, id: \.self) {
                            Text("Column \($0)")
                        }
                    }
                }.frame(height: 40, alignment: .leading)
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(0...10000, id: \.self) {
                            Text("Row \($0)")
                        }
                    }
                }.frame(width: 100, alignment: .leading)
                Spacer()
            }.padding(20)
        }
    }
}

struct ListExample: View {

    var body: some View {
        List {
            NavigationLink("列表操作") {
                ListExampleItem1()
                    .navigationBarTitle("列表操作", displayMode: .inline)
            }
            NavigationLink("邮箱") {
                ListExampleItem2()
                    .navigationBarTitle("邮箱", displayMode: .large)
            }
        }
    }

    struct ListExampleItem1: View {
        @State private var selection: Set<UUID> = []
        @State private var webSiteItems: [WebSiteItem] = []

        private var showItems: String {
            webSiteItems.map { String($0.title) }.joined(separator: ",")
        }

        var body: some View {
            VStack {
                Text("\(showItems)")
                List(selection: $selection) {
                    ForEach(webSiteItems) { item in
                        Text("\(item.title)")
                            .foregroundColor(self.selection.contains(item.id) ? Color.red : Color.primary)
                            .tag(item.id)
                            .itemProvider {
                            NSItemProvider(object: (URL(string: item.url) as NSItemProviderWriting?)!)
                        }
                    }.onDelete { index in
                        self.webSiteItems.remove(atOffsets: index)
                    }.onMove { from, to in
                        self.webSiteItems.move(fromOffsets: from, toOffset: to)
                    }.onInsert(of: ["public.url", "public.plain-text"], perform: self.insertItem(at: itemProvider:))
                }
                HStack {
                    EditButton().frame(maxWidth: .infinity)
                    Button("Add") {
                        self.webSiteItems.append(WebSiteItem(id: UUID(), url: "https://www.github.com", title: "Github \(Int.random(in: 0...10))"))
                    }.frame(maxWidth: .infinity)
                }.padding(.bottom, 20)
            }.onAppear {
                self.createData()
            }
        }

        struct WebSiteItem: Identifiable {
            var id = UUID()
            var url: String = ""
            var title: String = ""
        }

        private func createData() {
            let datas = [WebSiteItem(id: UUID(), url: "https://www.baidu.com", title: "百度"),
                         WebSiteItem(id: UUID(), url: "https://www.qq.com", title: "腾讯"),
                         WebSiteItem(id: UUID(), url: "https://www.taobao.com", title: "阿里"),
                         WebSiteItem(id: UUID(), url: "https://www.zhihu.com", title: "知乎"),
                         WebSiteItem(id: UUID(), url: "https://www.twitter.com", title: "推特"),
                         WebSiteItem(id: UUID(), url: "https://www.google.com", title: "谷歌")]
            self.webSiteItems.append(contentsOf: datas)
        }

        private func insertItem(at offset: Int, itemProvider: [NSItemProvider]) {
            // 分屏 从另一个程序拖进来 响应
            for provider in itemProvider {
                if provider.canLoadObject(ofClass: URL.self) {
                    _ = provider.loadObject(ofClass: URL.self) { url, error in
                        DispatchQueue.main.async {
                            url.map {
                                self.webSiteItems.insert(WebSiteItem(id: UUID(), url: $0.absoluteString, title: $0.absoluteString), at: offset)
                            }
                        }
                    }
                }
            }
        }
    }

    struct ListExampleItem2: View {

        @State private var datas: [ItemData] = []
        @State private var selectDataIds: Set<UUID> = []
        @State private var editMode = EditMode.inactive
        @State private var editing: Bool = false

        var body: some View {
            ZStack(alignment: .topLeading) {
                VStack {
                    List(selection: self.$selectDataIds) {
                        ForEach(datas) { item in
                            if self.editing || (!self.editing && item.show) {
                                itemView(item: item)
                                    .tag(item.id.uuidString)
                            }
                        }.onMove { from, to in
                            self.datas.move(fromOffsets: from, toOffset: to)
                        }
                        if self.editMode.isEditing {
                            cellAddButton()
                        }
                    }
                        .environment(\.editMode, self.$editMode)
                    Spacer()
                }
                bottomView()
            }.onAppear(perform: {
                self.createData()
            }).edgesIgnoringSafeArea(.bottom)
                .navigationBarItems(trailing: navEditButton())

        }

        func itemView(item: ItemData) -> some View {
            var unreadNumberText: Text {
                if item.unreadNumber > 0 {
                    return Text(String(item.unreadNumber)).foregroundColor(Color(hex: "#78787D"))
                }
                return Text("")
            }
            return HStack {
                Image(systemName: item.image)
                Text(item.title)
                Spacer()
                if !self.editMode.isEditing {
                    HStack {
                        unreadNumberText
                        Image(systemName: "chevron.right").scaleEffect(0.8).foregroundColor(Color(hex: "#78787D"))
                    }
                }
            }
        }

        func navEditButton() -> some View {
            Button(self.editMode.isEditing ? "完成" : "编辑") {
                switch self.editMode {
                case .active:
                    print("active")
                    withAnimation(.easeInOut) {
                        self.editing = false
                        self.editMode = .inactive
                    }
                    let selectIds = self.selectDataIds
                    _ = self.datas.map {
                        $0.show = selectIds.contains($0.id)
                    }
                case .inactive:
                    print("inactive")
                    withAnimation(.easeInOut) {
                        self.editing = true
                        self.editMode = .active
                    }
                default:
                    break;
                }
            }
        }

        func cellAddButton() -> some View {
            HStack {
                Rectangle().fill(Color.clear).frame(width: 65)
                Text("添加邮箱...")
                    .onTapGesture {
                    print("cell添加邮箱")
                }
            }
        }

        func bottomView() -> some View {
            return VStack {
                Spacer()
                if self.editing {
                    HStack {
                        Spacer()
                        Button(action: {
                            print("新建邮箱")
                        }, label: {
                            Text("新建邮箱").font(.system(size: 16)).foregroundColor(Color.black)
                                .padding(.bottom, 20)
                        }).padding(.trailing, 16)
                    }.frame(height: 90)
                        .background(RoundedRectangle(cornerRadius: 0).fill(Color.white))
                        .border(width: 1, edges: [.top], color: Color(hex: "#DCE0E0"))
                } else {
                    ZStack {
                        HStack {
                            Text("刚刚更新").font(.caption)
                        }.padding(.bottom, 20)
                        HStack {
                            Spacer()
                            Button(action: {
                                print("新邮件")
                            }, label: {
                                Image(systemName: "square.and.pencil")
                                    .font(.system(size: 22, weight: Font.Weight.regular))
                                    .foregroundColor(.black)
                                    .padding(.trailing, 16)
                            })
                        }.padding(.bottom, 20)
                    }.frame(height: 90)
                        .background(RoundedRectangle(cornerRadius: 0).fill(Color.white))
                }
            }
        }

        func createData() {
            self.datas = ItemData.mockData()
            self.selectDataIds = Set(self.datas.filter { $0.show }.map { $0.id })
        }

        // https://stackoverflow.com/questions/39330920/foreach-results-in-0-is-immutable-error
        // 此处用class类型是为了 动态修改datas中某个data的show状态
        class ItemData: Identifiable, Hashable {
            var id: UUID
            var title: String
            var image: String
            var unreadNumber: Int
            var show: Bool

            init(title: String, image: String, show: Bool) {
                self.id = UUID()
                self.title = title
                self.image = image
                self.unreadNumber = Int.random(in: 0...5)
                self.show = show
            }

            func hash(into hasher: inout Hasher) {
                hasher.combine(id)
            }

            static func == (lhs: ListExample.ListExampleItem2.ItemData, rhs: ListExample.ListExampleItem2.ItemData) -> Bool {
                return lhs.id == rhs.id
            }

            static func mockData() -> [ItemData] {
                let datas = [
                    ItemData(title: "收件箱", image: "tray", show: true),
                    ItemData(title: "VIP", image: "star", show: true),
                    ItemData(title: "有旗标", image: "flag", show: true),
                    ItemData(title: "未读", image: "envelope.badge", show: true),
                    ItemData(title: "收件人抄送", image: "person", show: true),
                    ItemData(title: "附件", image: "paperclip", show: true),
                    ItemData(title: "邮件主题通知", image: "bell", show: false),
                    ItemData(title: "今天", image: "calendar", show: false)
                ]
                return datas
            }

        }

    }

}

struct ScrollViewExample: View {
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 20) {
                    ForEach(0..<30) {
                        Text("\($0)")
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(.black)
                            .cornerRadius(16)
                    }
                }.padding(20)
            }
            ScrollView([.horizontal, .vertical]) {
                VStack(spacing: 10) {
                    ForEach(0..<30) { row in
                        HStack {
                            ForEach(0..<30) { column in
                                Text("\(row),\(column)")
                                    .foregroundColor(.white)
                                    .frame(width: 64, height: 64)
                                    .background(.black)
                                    .cornerRadius(32)
                            }
                        }
                    }
                }.frame(maxWidth: .infinity)
            }
        }
    }
}

// https://www.appcoda.com/learnswiftui/swiftui-gridlayout.html
struct GridExample: View {
    
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    private var threeColumnGrid = [GridItem(.fixed(50)), GridItem(.flexible()), GridItem(.flexible())]
//    private var columnGrid: [GridItem] = Array(repeating: .init(.flexible()), count: 6)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: threeColumnGrid) {
                ForEach(0...9999, id:\.self) {
                    Image(systemName: symbols[$0 % symbols.count])
                        .font(.system(size: 18))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                        .background(.random)
                        .cornerRadius(10)
                }
            }
        }
        Text("")
    }
}
