//
//  AudioRescueApp.swift
//  AudioRescue
//
//  Created by Boris Milev on 3.08.25.
//

import SwiftUI
import Cocoa
import UserNotifications

@main
struct AudioRescueApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            PreferencesView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusBarItem: NSStatusItem!
    private var popover: NSPopover!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupDefaults()
        setupMenuBar()
        setupNotifications()
    }
    
    func setupDefaults() {
        UserDefaults.standard.register(defaults: ["showNotifications": true])
    }
    
    func setupMenuBar() {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        if let button = statusBarItem.button {
            button.image = NSImage(systemSymbolName: "speaker.wave.3", accessibilityDescription: "Audio Rescue")
            button.action = #selector(showMenu)
            button.target = self
        }
    }
    
    @objc func showMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Reset Audio", action: #selector(resetAudio), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Preferences...", action: #selector(openPreferences), keyEquivalent: ","))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusBarItem.menu = menu
        statusBarItem.button?.performClick(nil)
        statusBarItem.menu = nil
    }
    
    @objc func resetAudio() {
        // First try the standard approach
        let script = """
        do shell script "sudo killall coreaudiod" with administrator privileges
        """
        
        let appleScript = NSAppleScript(source: script)
        var error: NSDictionary?
        let result = appleScript?.executeAndReturnError(&error)
        
        if let error = error {
            print("AppleScript error: \(error)")
            // Fallback: try without sudo
            attemptFallbackReset()
        } else {
            print("Audio reset successful")
            showNotification(title: "Audio Reset", message: "Core Audio has been restarted successfully.")
        }
    }
    
    private func attemptFallbackReset() {
        let fallbackScript = """
        do shell script "killall coreaudiod" with administrator privileges
        """
        
        let appleScript = NSAppleScript(source: fallbackScript)
        var error: NSDictionary?
        let result = appleScript?.executeAndReturnError(&error)
        
        if let error = error {
            print("Fallback AppleScript error: \(error)")
            showNotification(title: "Audio Reset Failed", message: "Unable to reset audio. Please run 'sudo killall coreaudiod' in Terminal.")
        } else {
            print("Fallback audio reset successful")
            showNotification(title: "Audio Reset", message: "Core Audio has been restarted successfully.")
        }
    }
    
    @objc func openPreferences() {
        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    func setupNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Notification authorization error: \(error)")
            }
        }
    }
    
    func showNotification(title: String, message: String) {
        let showNotifications = UserDefaults.standard.bool(forKey: "showNotifications")
        guard showNotifications else { return }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}
