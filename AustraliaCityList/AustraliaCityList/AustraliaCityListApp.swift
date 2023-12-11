//
//  AustraliaCityListApp.swift
//  AustraliaCityList
//
//  Created by raju.bannishetti on 11/12/23.
//

import SwiftUI

@main
struct AustraliaCityListApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            StateListView()
                .environmentObject(networkMonitor)
        }
    }
}
