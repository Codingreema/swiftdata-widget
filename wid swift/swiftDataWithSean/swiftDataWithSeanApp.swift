//
//  swiftDataWithSeanApp.swift
//  swiftDataWithSean
//
//  Created by rania on 19/06/1445 AH.
//

import SwiftUI
import SwiftData

@main
struct swiftDataWithSeanApp: App {
  

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for : [Expense.self])
    }
}
