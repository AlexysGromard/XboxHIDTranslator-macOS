//
//  XboxHIDTranslatorApp.swift
//  XboxHIDTranslator
//

import SwiftUI

@main
struct XboxHIDTranslatorApp: App {
    @StateObject private var hidManager = HIDManager()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(hidManager)
        }
    }
}
