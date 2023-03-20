//
//  SwiftUIView.swift
//  happy-bar
//
//  Created by hangj on 2023/3/18.
//

import SwiftUI
import WebKit
import LaunchAtLogin

struct SwiftUIView: View {
    @StateObject var state = UIState()

    var body: some View {
        VStack {
//            WebView(request: URLRequest(url: URL(string: "https://hangj.cnblogs.com")!))
            Text(state.v)
                .multilineTextAlignment(.leading)
                .foregroundColor(.green)
                .lineLimit(100)
            .frame(width: 80, height: 20, alignment: .leading)

//            LaunchAtLogin.Toggle()

//            Spacer()

            Text("Joshua Tree National Park")
        }
        .padding()

        Button("btn", action: foo)
    }

    func foo() {
        if state.v == "foo" {
            state.v = "bar"
        } else {
            state.v = "foo"
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
