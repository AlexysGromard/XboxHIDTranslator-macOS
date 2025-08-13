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
        VStack(spacing: 10) {
            Text("Xbox HID Translator")
                .font(.largeTitle)
                .padding()
            
            // Display translation status
            HStack {
                Text("Translation: ")
                Text("\(hidManager.isTranslationActive ? "ACTIVE" : "INACTIVE")")
                    .font(.headline)
                    .foregroundColor(hidManager.isTranslationActive ? .green : .red)
            }
            
            // Toggle button that changes based on current state
            Button(hidManager.isTranslationActive ? "Disable Translation" : "Enable Translation") {
                hidManager.toggleTranslation()
            }
            .background(hidManager.isTranslationActive ? Color.red : Color.green)
            .cornerRadius(8)
            
            // Debug toggle button
            Button(hidManager.isDebugVisible ? "Hide Debug" : "Show Debug") {
                hidManager.toggleDebug()
            }
            .background(hidManager.isDebugVisible ? Color.orange : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            // Debug logs display (only when debug is visible)
            if hidManager.isDebugVisible {
                ScrollView {
                    ForEach(hidManager.logLines, id: \.self) { line in
                        Text(line)
                            .font(.system(.body, design: .monospaced))
                            .padding(2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(10)
                .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 400)
                .background(Color.black.opacity(0.1))
                .cornerRadius(8)
                .defaultScrollAnchor(.bottom)
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
