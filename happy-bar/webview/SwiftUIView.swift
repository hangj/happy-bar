//
//  SwiftUIView.swift
//  happy-bar
//
//  Created by hangj on 2023/3/18.
//

import SwiftUI

struct SwiftUIView: View {
    @StateObject var state = UIState()

    var body: some View {
        VStack {
            Text(state.v)
                .multilineTextAlignment(.leading)
                .foregroundColor(.green)
                .lineLimit(100)
            .frame(width: 80, height: 20, alignment: .leading)

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
