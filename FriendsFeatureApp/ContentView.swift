//
//  ContentView.swift
//  FriendsFeatureApp
//
//  Created by Chinthaka Perera on 12/22/25.
//

import SwiftUI
import PlatformKit

/// Minimal host view for the Friends feature demo app.
///
/// Embeds a single `MicroFeature` (the Friends feature) so it can be
/// run and tested in isolation from the main shell application.
struct ContentView: View {
    
    /// The friends micro feature provided by the app entry point.
    let feature: MicroFeature

    var body: some View {
        
        // Render the feature's root SwiftUI view with some padding
        // to keep content visually separated from the screen edges.
        feature.makeRootView()
        .padding()
    }
}
