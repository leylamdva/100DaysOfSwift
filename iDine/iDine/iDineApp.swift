//
//  iDineApp.swift
//  iDine
//
//  Created by Leyla Mammadova on 2/7/22.
//

import SwiftUI

@main
struct iDineApp: App {
    @StateObject var order = Order()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
        }
    }
}
