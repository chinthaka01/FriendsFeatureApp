# FriendsFeatureApp

FriendsFeatureApp is a standalone SwiftUI demo app that embeds the **Friends** micro‑feature. It wires up only the minimal shared dependencies (networking and analytics) that the friends module needs so it can be developed, debugged, and showcased independently.

***

## Purpose

- Launch the Friends feature by itself, without other tabs or features.  
- Quickly test friends list UI, networking, and analytics behavior in the simulator.  
- Demonstrate how to compose a single micro‑feature into a simple host application.

***

## Architecture

FriendsFeatureApp reuses the same platform abstractions as the main Wefriendz shell:

- **PlatformKit**
  - `AnalyticsImpl` for logging analytics events.
  - `NetworkingImpl` for HTTP networking to the demo backend‑for‑frontend (BFF).
- **FriendsFeature**
  - `FriendsFeatureAPIClient` for feature‑specific network calls.
  - `FriendsDependenciesImpl` as the dependency container for the feature.
  - `FriendsFeatureFactory` which builds a `MicroFeature` representing the Friends entry point.

### App entry point: `FriendsFeatureApp`

Within `FriendsFeatureApp`:

- Shared services:
  - `analytics = AnalyticsImpl()`
  - `networking = NetworkingImpl()`
- Friends feature composition:
  - `friendsAPI = FriendsFeatureAPIClient(networking: networking)`
  - `friendsDependencies = FriendsDependenciesImpl(friendsAPI: friendsAPI, analytics: analytics)`
  - `friendsFactory = FriendsFeatureFactory(dependencies: friendsDependencies)`
  - `feature = friendsFactory.makeFeature()`
- Root scene:
  - The `body` uses a `WindowGroup` that renders `ContentView(feature: feature)`, so the app launches directly into the Friends feature UI.

### Host view: `ContentView`

- Holds:
  - `let feature: MicroFeature`
- Renders:
  - Returns `feature.makeRootView().padding()` from `body`, giving the Friends feature full control over its UI while adding some outer padding for nicer presentation on the demo host.

***

## Usage

1. Open the **FriendsFeatureApp** target in Xcode.  
2. Select an iOS Simulator device.  
3. Run the app:
   - The simulator opens directly into the Friends feature’s root screen.
   - Networking and analytics for friends flows use the same PlatformKit infrastructure as in the main app.

This setup lets you iterate on friends‑related experiences rapidly while still exercising the real platform and feature wiring.
