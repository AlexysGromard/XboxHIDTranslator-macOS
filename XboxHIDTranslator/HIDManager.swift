//
//  HIDManager.swift
//  XboxHIDTranslator
//

import Foundation
import IOKit.hid
import Combine


/// Manages HID (Human Interface Device) input using IOHIDManager.
/// Publishes incoming HID events as log lines to be used in SwiftUI views.
class HIDManager: ObservableObject {
    @Published var logLines = [String]() // Stores recent HID input events for UI display/
    @Published var isTranslationActive: Bool = false // Global state for translation activation
    @Published var isDebugVisible: Bool = false // Global state for debug display

    private var manager: IOHIDManager!

    init() {
        setupHID()
    }

    /// Configures and opens the HID manager.
    /// - Creates the IOHIDManager instance
    /// - Sets matching criteria for devices
    /// - Registers an input callback
    /// - Schedules it on the current run loop
    private func setupHID() {
        manager = IOHIDManagerCreate(kCFAllocatorDefault, IOOptionBits(kIOHIDOptionsTypeNone))

        // Device matching criteria: Microsoft vendor ID (0x045E)
        let matchingDict: [String: Any] = [
            kIOHIDVendorIDKey: 0x045E
        ]
        IOHIDManagerSetDeviceMatching(manager, matchingDict as CFDictionary)

        // Register input event callback
        IOHIDManagerRegisterInputValueCallback(manager, { context, result, sender, value in
            let element = IOHIDValueGetElement(value)
            let usagePage = IOHIDElementGetUsagePage(element)
            let usage = IOHIDElementGetUsage(element)
            let intValue = IOHIDValueGetIntegerValue(value)

            let line = "UsagePage: \(usagePage), Usage: \(usage), Value: \(intValue)"
            
            // Update published logs on the main thread
            DispatchQueue.main.async {
                let selfPtr = unsafeBitCast(context, to: HIDManager.self)
                selfPtr.logLines.append(line)
                if selfPtr.logLines.count > 1000 {
                    selfPtr.logLines.removeFirst()
                }
            }
        }, UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()))

        // Schedule manager in run loop and open it
        IOHIDManagerScheduleWithRunLoop(manager, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue)
        let result = IOHIDManagerOpen(manager, IOOptionBits(kIOHIDOptionsTypeNone))
        if result != kIOReturnSuccess {
            print("Failed to open HID Manager: \(result)")
        }
    }
        
    /// Toggle translation state
    func toggleTranslation() {
        isTranslationActive.toggle()
    }
    
    /// Toggle debug visibility
    func toggleDebug() {
        isDebugVisible.toggle()
    }
}
