//
//  ContinuityTransitionApp.swift
//  ContinuityTransition
//
//  Created by Victor on 23/03/2024.
//

import SwiftUI

@main
struct ContinuityTransitionApp: App {
    
    @StateObject var viewModel = HomeViewModel()
    @Namespace var namespace
    
    var body: some Scene {
        WindowGroup {
            HomeView(namespace: namespace, expand: ExpandSection(title: "Send", description: "Send tokens or collectibles to any address or ENS username.", imageName: "paperplane.fill", backgroundColor: .blue))
                .environmentObject(viewModel)
        }
    }
}
