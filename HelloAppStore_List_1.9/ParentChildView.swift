//
//  ParentChildView.swift
//  HelloAppStore_List_1.9
//
//  @State と @Binding の親子間での状態共有デモ
//

import SwiftUI

// 親View：@Stateで「原本」を持つ
struct ParentView: View {
    @State private var isShowingDetail = false

    var body: some View {
        VStack {
            // $を付けてBindingとして子に渡す
            ChildView(isShowing: $isShowingDetail)
            Text(isShowingDetail ? "表示中" : "非表示")
        }
    }
}

// 子View：@Bindingで「参照」を受け取る
struct ChildView: View {
    @Binding var isShowing: Bool

    var body: some View {
        Toggle("詳細を表示", isOn: $isShowing)
    }
}

#Preview("ParentView") {
    ParentView()
}
