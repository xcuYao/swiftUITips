//
//  LayoutElement.swift
//  SwiftUITip
//
//  Created by yaoning on 2022/1/22.
//

import SwiftUI

struct LayoutElement: View {

    @State var name: String = "HStack"
//    let layouts = ["NavigationView", "TabView", "HStack/VStack/ZStack", "LazyStack", "List", "ScrollView", "ScrollView", "Table", "Grid"]
    var body: some View {
        VStack {
            switch name {
            case "NavigationView":
                ScrollView {
                    HStackExample()
                }
            case "VStack":
                ScrollView {
                    VStackExample()
                }
            case "ZStack":
                ScrollView {
                    ZStackExample()
                }
            case "LazyStack":
                LazyStackExample()
            case "List":
                ListExample()
            default:
                Text("Default")
            }
        }.background(Color(hex: "#F2F2F7")).navigationBarTitle(Text(name), displayMode: .inline)
    }
}

struct LayoutElement_Previews: PreviewProvider {
    static var previews: some View {
        LayoutElement(name: "List")
    }
}

struct NavigationExample: View {
    var body: some View {
        Text("NavigationExample")
    }
}

struct TabViewExample: View {
    var body: some View {
        Text("TabViewExample")
    }
}

struct StackExample: View {
    var body: some View {
        Text("StackExample")
    }
}


struct HStackExample: View {
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 20) {
                ForEach(0...5, id: \.self) { i in
                    HStack { Text(String(i)).foregroundColor(.white) }.frame(width: 40, height: 40, alignment: .center).background(.red).cornerRadius(10)
                }
                Spacer()
            }.padding(20).background(Color.green)
            HStack(alignment: .center, spacing: 20) {
                Spacer()
                ForEach(0...5, id: \.self) { i in
                    HStack { Text(String(i)).foregroundColor(.white) }.frame(width: 40, height: 40, alignment: .center).background(.red).cornerRadius(10)
                }
            }.padding(20).background(Color.green)
            Spacer()
        }
    }
}

struct VStackExample: View {
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 20) {
                ForEach(0...5, id: \.self) { i in
                    HStack { Text(String(i)).foregroundColor(.white) }.frame(width: 40, height: 40, alignment: .center).background(.red).cornerRadius(10)
                }
                Spacer()
            }.padding(20).background(Color.green)
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                ForEach(0...5, id: \.self) { i in
                    HStack { Text(String(i)).foregroundColor(.white) }.frame(width: 40, height: 40, alignment: .center).background(.red).cornerRadius(10)
                }
            }.padding(20).background(Color.green)
            Spacer()
        }
    }
}

struct ZStackExample: View {
    var body: some View {
        HStack {
            VStack {
                ZStack() {
                    ForEach(0...5, id: \.self) { i in
                        HStack { Text(String(i)).foregroundColor(.white) }.frame(width: 40, height: 40, alignment: .center).background(.random).cornerRadius(10).offset(x: CGFloat(i * 10), y: CGFloat(i * 30))
                    }
                    Spacer()
                }.frame(width: 100, height: 300, alignment: .top).padding(20).background(Color.green).clipped()
            }
            Spacer()
        }
    }
}

struct LazyStackExample: View {
    var body: some View {
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
        @State var selection: Set<UUID> = []
        @State var webSiteItems: [WebSiteItem] = []

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

        @State var datas: [ItemData] = []
        @State var selectDataIds: Set<UUID> = []
        @State var editMode = EditMode.inactive
        @State var editing: Bool = false

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
