//
//  TodoListApp.swift
//  TodoList
//
//  Created by Ome Asraf on 6/23/21.
//

import SwiftUI


@main
struct TodoListApp: App {
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
