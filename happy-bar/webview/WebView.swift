//
//  WebView.swift
//  happy-bar
//
//  Created by hangj on 2023/3/20.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    let request: URLRequest
    func makeNSView(context _: Context) -> WKWebView {
        WKWebView()
    }

    func updateNSView(_ uiView: WKWebView, context _: Context) {
        uiView.load(request)
    }
}

struct WebPanelView: View {
    let request: URLRequest
    var body: some View {
        VStack {
            WebView(request: request)
        }
    }
}
