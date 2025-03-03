//
//  sampleApp.swift
//  sample
//
//  
//

import SwiftUI


@main
struct SampleApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TabView {
                    HomeScreen()
                        .tabItem {
                            Image(systemName: "airplane")
                            Text("Explore")
                        }
                    
                    ProfileView() 
                        .tabItem {
                            Image(systemName: "person.crop.circle")
                            Text("Profile")
                        }
                }
            }
        }
    }
}

