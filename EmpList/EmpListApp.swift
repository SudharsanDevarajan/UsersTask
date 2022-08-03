//
//  EmpListApp.swift
//  EmpList
//
//  Created by htcuser on 03/08/22.
//

import SwiftUI

@main
struct EmpListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            EmpView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
