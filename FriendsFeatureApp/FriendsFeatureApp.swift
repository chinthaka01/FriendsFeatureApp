//
//  FriendsFeatureApp.swift
//  FriendsFeatureApp
//
//  Created by Chinthaka Perera on 12/22/25.
//

import SwiftUI
import PlatformKit
import FriendsFeature

@main
struct FriendsFeatureApp: App {
    let analytics = AnalyticsImpl()
    let friendsAPI = FriendsFeatureAPIClient()
    let friendsDependencies: FriendsDependenciesImpl
    let friendsFactory: FriendsFeatureFactory
    let feature: MicroFeature
    
    init() {
        friendsDependencies = FriendsDependenciesImpl(friendsAPI: friendsAPI, analytics: analytics)
        friendsFactory = FriendsFeatureFactory(dependencies: friendsDependencies)
        feature = friendsFactory.makeFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(feature: feature)
        }
    }
}
