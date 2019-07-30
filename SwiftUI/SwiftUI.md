
```swift
import SwiftUI                               // (NS/UI)Kit–agnostic

struct ProfileEditor: View {                 // View is a Swift protocol
    @Binding var profile: Profile            // @Binding is a property wrapper
    @State private var showAdvanced: Bool    // @State is another property wrapper
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

# [fit] **SwiftUI**
## **Declarative** User-Interface Development 
### Marc Prud'hommeaux <*marc@glimpse.io*>
#### SwiftFest Boston, July 30, 2019

---

About Me

- Independent iOS developer since 2008
- Local to Boston area
- Swift Consultation & Training:
  1. UI Development
  1. Swift migration
  1. **NEW** SwiftUI adoption 
  
  ### marc@glimpse.io
  
---

# Disclaimer

## Information current as of *yesterday* (July 29, 2019)
-  Xcode 11 beta 4
- macOS 10.15 (“Catalina”) beta 4

---

# SwiftUI Features

- Declarative View Builder Syntax
- Live previews
- Bindings & State Management
- Cross(*-ish*)-platform development
- Interoperability with existing Cocoa(Touch) views


---

# What is gained?

---

## **Gains**

- UI in Code
  - Single Source of Truth
  - Better Diffing & Source Control
- Declarative View Builders
  - Automatic view flattening
- State Management
  - Bindings
  
---

# What is lost?

- Pre-iOS13/macOS10.15 Support
- Interface Builder
  - Design & Development Separation of Concerns
  - Mitigated by Xcode-integrated *Preview Content*
  
---

# What is a (UI/NS/SwiftUI)View?

- `AppKit.NSView` – macOS ObjC class (1989 – *NeXTSTEP*)
- `UIKit.UIView` - iOS ObjC class (2008 – *Cocoa Touch*)
    - Objective-C **reference** type that directly represents a drawable instance on the screen
  
- `SwiftUI.View` - Cross-platform Swift protocol (circa 2019)
    - Swift **value** type that that *builds* and *maintains* hierarchies of `NSView`s, `UIView`s, and `CALayer`s.
 
---

# Swift 5.1 Language Enhancements
1. Opaque Result Types (SE-0244)
2. Property Wrappers (SE-0258)
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
• State-intensive apps

---

# When *not* to use SwiftUI:
• Objective-C-mostly
• Pre-iOS13 devices
• Core Data Reliance
• Mostly custom views (games, etc.)
• Need storyboards

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

# Nicities

SwiftUI vs. Swift + Interface Builder:

We no longer have to argue about programmatic or storyboard-based design, because SwiftUI gives us both at the same time.
We no longer have to worry about creating source control problems when committing user interface work, because code is much easier to read and manage than storyboard XML.
We no longer need to worry so much about stringly typed APIs – there are still some, but significantly fewer.
We no longer need to worry about calling functions that don’t exist, because our user interface gets checked by the Swift compiler.

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

Should I use SwiftUI?

  • Target OS
  • Swift-mostly app
  • Cross-platorm requirements
  • State management

---

When is a (NS/UI)View not a view? When it is a (SwiftUI.)View

---

Nicities

  • Good Accessibility support
  
---

Warts

  • Compiler error red herrings
  • Missing controls (Color picker / outline view)
  • Limit of 10 controls per view builder:  

  "Type of expression is ambiguous without more context"

  "Function declares an opaque return type, but has no return statements in its body from which to infer an underlying type"

  "Function declares an opaque return type, but the return statements in its body do not have matching underlying types"

  "Property definition has inferred type 'some View', involving the 'some' return type of another declaration"

  "Closure containing control flow statement cannot be used with function builder 'ViewBuilder'"
  
  • Excess matching foils code-completion
  • Lack of complex control flow statements in "DSL"

---

Tips

  • Break up large views
  • Keep view construction quick


---

![](/Users/marc/Downloads/237_sd_building_custom_views_with_swiftui.mp4)

---

## [fit] **WWDC VIDEOS**

## https://developer.apple.com/videos/wwdc2019/

**204**: Introducing SwiftUI: Building Your First App
**216**: SwiftUI Essentials
**226**: Data Flow Through SwiftUI
**231**: Integrating SwiftUI
**237**: Building Custom Views with SwiftUI
**240**: SwiftUI On All Devices

---

# [fit] –**Q&A**–

### **ME**: Marc Prud'hommeaux <**marc@glimpse.io**>
### **DOCS**: https://developer.apple.com/documentation/swiftui
### **TUTORIALS**:  https://developer.apple.com/tutorials
### **PRESENTATION**: https://github.com/glimpseio/Presentations

