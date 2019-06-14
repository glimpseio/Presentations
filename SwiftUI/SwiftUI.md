

```swift
import SwiftUI                               // (NS/UI)Kit–agnostic

struct ProfileEditor: View {                 // View is a Swift protocol
    @Binding var profile: Profile            // @Binding is a property delegate
    @State private var showAdvanced: Bool    // @State is another property delegate
    var body: some View {                    // `some` is an "opaque type"
        List {                               // @_functionBuilder ViewBuilder 
            HStack {                         // Lightweight builder for a stack view
                Text("Username").bold()      // Configure using a fluent API
                Divider()                    // Where are the commas?
                TextField($profile.username) // `$` derives a binding from @Binding
            }
            
            Toggle(isOn: $showAdvanced) {    // `$` can derive from @State too
                Text("Enable Notifications")
            }
        }
    }
}
```

---

# SwiftUI
## Native & Declarative UI Framework for Apple Platforms
### Marc Prud'hommeaux <*marc@glimpse.io*>
#### Boston CocoaHeads, June 13, 2019

---

# [fit] “Learn once, apply everywhere.”

![](https://developer.apple.com/home/images/hero-apple-platforms-20cc1/large_2x.jpg)

---

# What is a (UI/NS)View?

### `AppKit.NSView` – macOS ObjC class (circa 1989)
### `UIKit.UIView` - iOS/tvOS/watchOS ObjC class (circa 2008)

### `SwiftUI.View` - Cross-platform Swift protocol (circa 2019)

  Designed to be implemented by Swift value types (structs & enums) that *builds* and *maintains* hierarchies of `NSView`s, `UIView`s, and `CALayer`s.
 
### **No APIs have been removed or deprecated**


---

# Swift 5.1 Language Enhancements
1. Opaque Result Types (SE-0244)
2. Property Delegates (SE-0258)
3. Function Builders (draft proposal)

---

```swift
import SwiftUI                               // "Kit"–agnostic

struct ProfileEditor: View {                 // View is a swift-only protocol
    @State private var showAdvanced: Bool    // @State is another property delegate
    @Binding var profile: Profile            // @Binding is a property delegate
    var body: some View {                    // `some` is an "opaque type"
        List {                               // @_functionBuilder ViewBuilder 
            HStack {                         // Lightweight builder for a stack view
                Text("Username").bold()      // Configure using a fluent API
                Divider()                    // Where are the commas?
                TextField($profile.username) // `$` derives a binding from @Binding
            }
            
            Toggle(isOn: $showAdvanced) {    // `$` can derive from @State too
                Text("Enable Notifications")
            }
        }
    }
}
```

---

```swift, [.highlight: 1]
import SwiftUI                               // "Kit"–agnostic

struct ProfileEditor: View {                 // View is a swift-only protocol
    @State private var showAdvanced: Bool    // @State is another property delegate
    @Binding var profile: Profile            // @Binding is a property delegate
    var body: some View {                    // `some` is an "opaque type"
        List {                               // @_functionBuilder ViewBuilder 
            HStack {                         // Lightweight builder for a stack view
                Text("Username").bold()      // Configure using a fluent API
                Divider()                    // Where are the commas?
                TextField($profile.username) // `$` derives a binding from @Binding
            }
            
            Toggle(isOn: $showAdvanced) {    // `$` can derive from @State too
                Text("Enable Notifications")
            }
        }
    }
}
```

---

```swift, [.highlight: 3]
import SwiftUI                               // "Kit"–agnostic

struct ProfileEditor: View {                 // View is a swift-only protocol
    @Binding var profile: Profile            // @Binding is a property delegate
    @State private var showAdvanced: Bool    // @State is another property delegate    
    var body: some View {                    // `some` is an "opaque type"
        List {                               // @_functionBuilder ViewBuilder 
            HStack {                         // Lightweight builder for a stack view
                Text("Username").bold()      // Configure using a fluent API
                Divider()                    // Where are the commas?
                TextField($profile.username) // `$` derives a binding from @Binding
            }
            
            Toggle(isOn: $showAdvanced) {    // `$` can derive from @State too
                Text("Enable Notifications")
            }
        }
    }
}
```


---

```swift, [.highlight: 4]
import SwiftUI                               // "Kit"–agnostic

struct ProfileEditor: View {                 // View is a swift-only protocol
    @State private var showAdvanced: Bool    // @State is another property delegate
    @Binding var profile: Profile            // @Binding is a property delegate
    var body: some View {                    // `some` is an "opaque type"
        List {                               // @_functionBuilder ViewBuilder 
            HStack {                         // Lightweight builder for a stack view
                Text("Username").bold()      // Configure using a fluent API
                Divider()                    // Where are the commas?
                TextField($profile.username) // `$` derives a binding from @Binding
            }
            
            Toggle(isOn: $showAdvanced) {    // `$` can derive from @State too
                Text("Enable Notifications")
            }
        }
    }
}
```


---

```swift, [.highlight: 6]
import SwiftUI                               // "Kit"–agnostic

struct ProfileEditor: View {                 // View is a swift-only protocol
    @State private var showAdvanced: Bool    // @State is another property delegate
    @Binding var profile: Profile            // @Binding is a property delegate
    var body: some View {                    // `some` is an "opaque type"
        List {                               // @_functionBuilder ViewBuilder 
            HStack {                         // Lightweight builder for a stack view
                Text("Username").bold()      // Configure using a fluent API
                Divider()                    // Where are the commas?
                TextField($profile.username) // `$` derives a binding from @Binding
            }
            
            Toggle(isOn: $showAdvanced) {    // `$` can derive from @State too
                Text("Enable Notifications")
            }
        }
    }
}
```


---

```swift, [.highlight: 7]
import SwiftUI                               // "Kit"–agnostic

struct ProfileEditor: View {                 // View is a swift-only protocol
    @State private var showAdvanced: Bool    // @State is another property delegate
    @Binding var profile: Profile            // @Binding is a property delegate
    var body: some View {                    // `some` is an "opaque type"
        List {                               // @_functionBuilder ViewBuilder 
            HStack {                         // Lightweight builder for a stack view
                Text("Username").bold()      // Configure using a fluent API
                Divider()                    // Where are the commas?
                TextField($profile.username) // `$` derives a binding from @Binding
            }
            
            Toggle(isOn: $showAdvanced) {    // `$` can derive from @State too
                Text("Enable Notifications")
            }
        }
    }
}
```


---

```swift, [.highlight: 8]
import SwiftUI                               // "Kit"–agnostic

struct ProfileEditor: View {                 // View is a swift-only protocol
    @State private var showAdvanced: Bool    // @State is another property delegate
    @Binding var profile: Profile            // @Binding is a property delegate
    var body: some View {                    // `some` is an "opaque type"
        List {                               // @_functionBuilder ViewBuilder 
            HStack {                         // Lightweight builder for a stack view
                Text("Username").bold()      // Configure using a fluent API
                Divider()                    // Where are the commas?
                TextField($profile.username) // `$` derives a binding from @Binding
            }
            
            Toggle(isOn: $showAdvanced) {    // `$` can derive from @State too
                Text("Enable Notifications")
            }
        }
    }
}
```



---

```swift, [.highlight: 9]
import SwiftUI                               // "Kit"–agnostic

struct ProfileEditor: View {                 // View is a swift-only protocol
    @State private var showAdvanced: Bool    // @State is another property delegate
    @Binding var profile: Profile            // @Binding is a property delegate
    var body: some View {                    // `some` is an "opaque type"
        List {                               // @_functionBuilder ViewBuilder 
            HStack {                         // Lightweight builder for a stack view
                Text("Username").bold()      // Configure using a fluent API
                Divider()                    // Where are the commas?
                TextField($profile.username) // `$` derives a binding from @Binding
            }
            
            Toggle(isOn: $showAdvanced) {    // `$` can derive from @State too
                Text("Enable Notifications")
            }
        }
    }
}
```

---

```swift, [.highlight: 10]
import SwiftUI                               // "Kit"–agnostic

struct ProfileEditor: View {                 // View is a swift-only protocol
    @State private var showAdvanced: Bool    // @State is another property delegate
    @Binding var profile: Profile            // @Binding is a property delegate
    var body: some View {                    // `some` is an "opaque type"
        List {                               // @_functionBuilder ViewBuilder 
            HStack {                         // Lightweight builder for a stack view
                Text("Username").bold()      // Configure using a fluent API
                Divider()                    // Where are the commas?
                TextField($profile.username) // `$` derives a binding from @Binding
            }
            
            Toggle(isOn: $showAdvanced) {    // `$` can derive from @State too
                Text("Enable Notifications")
            }
        }
    }
}
```

---

```swift, [.highlight: 11]
import SwiftUI                               // "Kit"–agnostic

struct ProfileEditor: View {                 // View is a swift-only protocol
    @State private var showAdvanced: Bool    // @State is another property delegate
    @Binding var profile: Profile            // @Binding is a property delegate
    var body: some View {                    // `some` is an "opaque type"
        List {                               // @_functionBuilder ViewBuilder 
            HStack {                         // Lightweight builder for a stack view
                Text("Username").bold()      // Configure using a fluent API
                Divider()                    // Where are the commas?
                TextField($profile.username) // `$` derives a binding from @Binding
            }
            
            Toggle(isOn: $showAdvanced) {    // `$` can derive from @State too
                Text("Enable Notifications")
            }
        }
    }
}
```


---

# Tooling

• Design & Preview in XCode: “Hot Reload”
• No more Interface Builder nib/xib diffing

---

# When to use SwiftUI:
• Swift-only
• Model consists of value types (structs & enums)
• Apps w/out legacy OS requirements (iOS13+ / macOS10.15+)


# When *not* to use SwiftUI:
• Objective-C-mostly
• Pre-iOS13 devices
• Core Data Reliance
• Mostly custom views (games, etc.)

---

# Migration & Interoperability

(App/UI)Kit views can be hosted in SwiftUI hierarchies

    UIViewRepresentable
    UIViewControllerRepresentable
    NSViewRepresentable
    NSViewControllerRepresentable

(App/UI)Kit views can contain SwiftUI hierarchies
    
    UIHostingController
    NSHostingController


---

# API Design

• Builder pattern
• Fluent interface w/ method chaining

```swift
    Text("Hi!").color(.red).padding().cornerRadius(5).clipped().opacity(0.9)
```


---

# Opaque Types Rationale

```swift
let view: _ModifiedContent
  <_ModifiedContent
    <_ModifiedContent
      <_ModifiedContent
        <Text, _PaddingLayout>, 
        _ClipEffect<RoundedRectangle>>,
     _ClipEffect<Rectangle>>, 
    _OpacityEffect> 
    = Text("Hi!").color(.red).padding().cornerRadius(5).clipped().opacity(0.9)
```

---

# Combine
• FRP for Swift
• e.g., RxSwift / ReactiveCocoa / Mobius  
• SwiftUI + Combine == AppKit + Cocoa Bindings

---

# Prior Art
• ReactiveX (Microsoft+)
• React / ReactNative / Redux (Facebook+)
• Flutter (Google)

---

# Catalyst: "UIKit for Mac"

• SwiftUI on macOS in "UIKit Mode"
• vs. SwiftUI on macOS in "AppKit Mode"
• Used for Stocks.app / News.app / Find My.app / etc.

---

# Swift & Flutter

```swift
ForEach(userData.landmarks) { landmark in
    if !self.userData.showFavoritesOnly || landmark.isFavorite {
        NavigationButton(
        destination: LandmarkDetail(landmark: landmark)) {
            LandmarkRow(landmark: landmark)
        }
    }
}
```

    https://medium.com/flutter-nyc/building-the-swiftui-sample-app-in-flutter-67bb4f9c571c


---

# Flutter Equivalent

```js
SliverList(delegate: SliverChildBuilderDelegate((context, index) {
      final landmark = landmarks[index];
      return LandmarkCell(landmark: landmark, onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => LandmarkDetail(
                landmark: landmark,
              ),
            ),
          );
        },
      );
    },
    childCount: landmarks.length,
  ),
)
```

---

# View Collapsing

SwiftUI can decide whether to render your Views as `UIView`s or `CALayer`s:

```swift
  View.drawingGroup()
  View.compositingGroup()
```

    Session 237: Building Custom Views with SwiftUI (time 37:00)

---

![](/Users/marc/Downloads/237_sd_building_custom_views_with_swiftui.mp4)

---

### Videos: https://developer.apple.com/videos/wwdc2019/

• 204: Introducing SwiftUI: Building Your First App
• 216: SwiftUI Essentials
• 226: Data Flow Through SwiftUI
• 231: Integrating SwiftUI
• 237: Building Custom Views with SwiftUI
• 240: SwiftUI On All Devices

---

# *Bon Mots*

"Views are a function of state, not a sequence of events."
"SwiftUI is the shortest path to building great apps on *every* device."

# References

    https://developer.apple.com/documentation/swiftui
    https://developer.apple.com/tutorials/swiftui
    https://github.com/glimpseio/Presentations

--- 

# [fit] Questions!



