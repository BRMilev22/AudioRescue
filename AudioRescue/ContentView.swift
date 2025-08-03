//
//  ContentView.swift
//  AudioRescue
//
//  Created by Boris Milev on 3.08.25.
//

import SwiftUI
import ServiceManagement

struct PreferencesView: View {
    @AppStorage("launchAtLogin") private var launchAtLogin = false
    @AppStorage("showNotifications") private var showNotifications = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "speaker.wave.3")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                VStack(alignment: .leading) {
                    Text("AudioRescue")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("MacBook Pro Audio Fix")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Preferences")
                    .font(.headline)
                
                Toggle("Launch at login", isOn: $launchAtLogin)
                    .onChange(of: launchAtLogin) { _, newValue in
                        toggleLaunchAtLogin(newValue)
                    }
                
                Toggle("Show notifications", isOn: $showNotifications)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("About")
                    .font(.headline)
                
                Text("AudioRescue fixes audio stuttering issues on MacBook Pro 2023/2024 by resetting the Core Audio daemon.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("Command: sudo killall coreaudiod")
                    .font(.caption)
                    .fontDesign(.monospaced)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .frame(width: 400, height: 300)
    }
    
    private func toggleLaunchAtLogin(_ enabled: Bool) {
        if enabled {
            try? SMAppService.mainApp.register()
        } else {
            try? SMAppService.mainApp.unregister()
        }
    }
}

#Preview {
    PreferencesView()
}
