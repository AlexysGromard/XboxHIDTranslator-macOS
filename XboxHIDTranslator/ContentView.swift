//
//  ContentView.swift
//  XboxHIDTranslator
//
//  Created by Alexys Gromard on 12/08/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var hidManager: HIDManager

    var body: some View {
        VStack {
            Text("Xbox HID Translator")
                .font(.largeTitle)
                .padding()

            ScrollView {
                ForEach(hidManager.logLines, id: \.self) { line in
                    Text(line)
                        .font(.system(.body, design: .monospaced))
                        .padding(2)
                }
            }
            .frame(minHeight: 300)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
