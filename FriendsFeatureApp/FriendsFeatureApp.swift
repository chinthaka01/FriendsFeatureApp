//
//  FriendsFeatureApp.swift
//  FriendsFeatureApp
//
//  Created by Chinthaka Perera on 12/22/25.
//

import SwiftUI
import PlatformKit
import FriendsFeature

/// Standalone test app for the Friends feature.
///
/// Composes the platform dependencies and launches only the
/// Friends micro feature, without the full Wefriendz shell UI.
@main
struct FriendsFeatureApp: App {
    
    /// Shared analytics implementation for this demo app.
    let analytics = AnalyticsImpl()
    
    /// Shared networking implementation used by the friends API client.
    let networking = NetworkingImpl()
    
    /// Concrete API client used by the Friends feature.
    let friendsAPI: FriendsFeatureAPIClient
    
    /// Dependency container injected into the Friends feature factory.
    let friendsDependencies: FriendsDependenciesImpl
    
    /// Factory responsible for creating the Friends micro feature.
    let friendsFactory: FriendsFeatureFactory
    
    /// The Friends `MicroFeature` instance rendered by this app.
    let feature: MicroFeature
    
    init() {
        friendsAPI = FriendsFeatureAPIClient(networking: networking)
        friendsDependencies = FriendsDependenciesImpl(
            friendsAPI: friendsAPI,
            analytics: analytics
        )
        friendsFactory = FriendsFeatureFactory(dependencies: friendsDependencies)
        feature = friendsFactory.makeFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            // Minimal host view that embeds only the Friends feature.
            ContentView(feature: feature)
        }
    }
}
