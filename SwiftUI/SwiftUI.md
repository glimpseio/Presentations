

```swift
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

# SwiftUI
## Native & Declarative UI Framework for Apple Platforms
### Marc Prud'hommeaux <*marc@glimpse.io*>
#### Boston CocoaHeads, June 13, 2019

---

# What is a (UI/NS)View?

### `AppKit.NSView` – macOS ObjC class (circa 1989)
### `UIKit.UIView` - iOS/tvOS/watchOS ObjC class (circa 2008)

### `SwiftUI.View` - Cross-platform Swift protocol (circa 2019)

  Designed to be implemented by Swift value types (structs & enums) that *builds* and *maintains* hierarchies of `NSView`s, `UIView`s, and `CALayer`s.
 
### **No APIs have been removed or deprecated**

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

# Property Delegates
## Swift Language Enhancements


---

# Tooling

• Design & Preview in Code
• Interface Builder no more

---

# Swift Sample

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

---

# Flutter Equivalent

```js
SliverList(
  delegate: SliverChildBuilderDelegate(
    (context, index) {
      final landmark = landmarks[index];
      return LandmarkCell(
        landmark: landmark,
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => LandmarkDetail(
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

# API Design

• Builder pattern
• Fluent interface w/ method chaining


---

# Catalyst: "UIKit for Mac"

• SwiftUI 
• Used for Stocks.app / News.app / Find My.app / etc.

---

# Combine
• FRP for Swift
• e.g., RxSwift / ReactiveCocoa / Mobius  

---

### Videos: https://developer.apple.com/videos/wwdc2019/

• 204: Introducing SwiftUI: Building Your First App
• 216: SwiftUI Essentials
• 226: Data Flow Through SwiftUI
• 231: Integrating SwiftUI
• 237: Building Custom Views with SwiftUI
• 240: SwiftUI On All Devices

---

# References

https://developer.apple.com/documentation/swiftui
https://developer.apple.com/tutorials/swiftui

# *Bon Mots*

"Learn once, apply everywhere."
"Views are a function of state, not a sequence of events."
"SwiftUI is the shortest path to building great apps on *every* device."


