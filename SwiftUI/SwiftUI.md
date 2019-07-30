
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

## [fit]`https://github.com/glimpseio/Presentations/`
#### [fit] `…/blob/master/SwiftUI/SwiftUIShapeShifter/SwiftUIShapeShifter/ShapeShifter.swift`

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
struct ShapeShifterModel : Hashable, Codable {
    enum ShapeKind : String, Hashable, Codable, CaseIterable {
        case square, circle
    }

    var kind = ShapeKind.circle
    var fill = HSL(hue: 0.66)
    var outline = HSL(hue: 0.08)
    var outlineWidth = 15.0

    /// A model of a color
    struct HSL : Hashable, Codable {
        var hue = 0.0
        var saturation = 1.0
        var brightness = 1.0
        var opacity = 1.0
    }
}
```
---

```swift
import SwiftUI

extension ShapeShifterModel.HSL {
    /// Convert the `HSL` model into a `SwiftUI.Color`
    var color: SwiftUI.Color {
        Color(hue: hue, saturation: saturation, brightness: brightness, opacity: opacity)
    }

    /// Static constants for pre-defined colors
    static let swatches = [
        Self(saturation: 0.00, brightness: 0.00), // black
        Self(brightness: 1.00), // red
        Self(hue: 0.33), // green
        Self(hue: 0.66), // blue
        Self(hue: 0.50), // cyan
        Self(hue: 0.16), // yellow
        Self(hue: 0.83), // magenta
        Self(hue: 0.08), // orange
        Self(hue: 0.83, brightness: 0.50), // purple
        Self(hue: 0.08, saturation: 0.66, brightness: 0.60), // brown
    Self(saturation: 0.00), // white
    ]
}
```
---

```swift
struct ShapeShifterRootView: SwiftUI.View {
    @EnvironmentObject var env: ShapeShifterEnv

    var body: some SwiftUI.View {
        VStack {
            ShapePreview(model: $env.model).scaledToFit().padding()
            Divider()
            ShapeInspector(model: $env.model)
        }
    }
}
```
---

```swift
struct ShapePreview: SwiftUI.View {
    @Binding var model: ShapeShifterModel

    var body: some SwiftUI.View {
        return ZStack {
            if model.kind == .circle {
                Circle().fill(model.fill.color)
                Circle().strokeBorder(model.outline.color, 
                    lineWidth: CGFloat(model.outlineWidth))
            } else if model.kind == .square {
                Rectangle().fill(model.fill.color)
                Rectangle().strokeBorder(model.outline.color, 
                    lineWidth: CGFloat(model.outlineWidth))
            }
        }
    }
}
```
---

```swift
struct ShapeInspector: SwiftUI.View {
    @Binding var model: ShapeShifterModel
    @State private var showFill = false
    @State private var showOutline = false

    var body: some SwiftUI.View {
        VStack {
            SegmentedControl(selection: $model.kind) {
                ForEach(ShapeShifterModel.ShapeKind.allCases, id: \.self) { kind in
                    Text(kind.rawValue.capitalized).tag(kind)
                }
            }

            Form {
                HSLSliders(label: "Fill", color: $model.fill, shown: $showFill)
                HSLSliders(label: "Outline", color: $model.outline, shown: $showOutline)
                Slider(value: $model.outlineWidth, from: 0, through: 100).padding()
            }

            UndoRedoButtons()
        }
    }
}
```
---

```swift
/// A collection of sliders that modify a `ShapeShifterModel.HSL` model object.
struct HSLSliders: SwiftUI.View {
    let label: String
    @Binding var color: ShapeShifterModel.HSL
    @Binding var shown: Bool

    var body: some SwiftUI.View {
        Section(header: Button(action: { self.$shown.value.toggle() }, 
            label: { Text(label) }).font(.title), footer: SwatchPicker(color: $color)) {
            if shown {
                PercentSlider(label: "Hue", value: $color.hue)
                PercentSlider(label: "Saturation", value: $color.saturation)
                PercentSlider(label: "Brightness", value: $color.brightness)
                PercentSlider(label: "Opacity", value: $color.opacity)
            }
        }
    }
}
```
---

```swift
/// A picker for common colors
struct SwatchPicker: SwiftUI.View  {
    @Binding var color: ShapeShifterModel.HSL
    var body: some SwiftUI.View {
        HStack {
            ForEach(ShapeShifterModel.HSL.swatches, id: \.self) { swatch in
                Button(action: {
                    self.color = swatch
                }, label: {
                    Rectangle()
                        .fill(swatch.color)
                        .aspectRatio(contentMode: .fit)
                        .frame(idealWidth: 50, idealHeight: 50)
                }).border(Color.primary, width: self.color == swatch ? 3 : 0)
            }
        }
    }
}
```
---

```swift
/// A slider that shows a text label with the value
struct PercentSlider: SwiftUI.View {
    let label: String
    @Binding var value: Double

    /// Shared formatter for making displaying a percent number
    private static let percentFormatter: Formatter = {
        let fmt = NumberFormatter()
        fmt.numberStyle = .percent
        return fmt
    }()

    var body: some SwiftUI.View {
        HStack {
            Text(label).frame(minWidth: 100, alignment: .trailing)
            Slider(value: $value, from: 0.0, through: 1.0)
            Text("\(value as NSNumber, formatter: Self.percentFormatter)")
        }
    }
}
```
---

```swift
struct UndoRedoButtons: SwiftUI.View {
    @EnvironmentObject var env: ShapeShifterEnv

    var body: some SwiftUI.View {
        HStack {
            Button("Undo") { self.env.undoManager?.undo() }
                .disabled(self.env.undoManager?.canUndo == false)
                .font(.title).buttonStyle(.default)
            Spacer()
            Button("Redo") { self.env.undoManager?.redo() }
                .disabled(self.env.undoManager?.canRedo == false)
                .font(.title).buttonStyle(.default)

        }.padding()
    }
}
```
---

```swift
#if DEBUG
struct ShapeShifterRootView_Previews: PreviewProvider {
    static var previews: some View {
        let env = ShapeShifterEnv()
        env.undoManager = UndoManager()
        return ShapeShifterRootView()
            .environmentObject(env)
            .previewDevice("iPhone SE") // the best device
    }
}
#endif
```
---

```swift
import Combine

final class ShapeShifterEnv : BindableObject {
    let willChange = Combine.PassthroughSubject<ShapeShifterModel, Never>()
    var undoManager: UndoManager? = nil
    var model = ShapeShifterModel() {
        willSet {
            let (oldModel, newModel) = (self.model, newValue)
            // any changes to the model will be registered with the undo manager
            if let um = self.undoManager, um.isUndoRegistrationEnabled {
                um.registerUndo(withTarget: self) { target in
                    withAnimation(Animation.spring(blendDuration: 2.5)) {
                        target.model = oldModel
                    }
                }
            }

            willChange.send(newModel) // inform listeners of changes
        }
    }
}
```
---

```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, 
        configurationForConnecting session: UISceneSession, 
        options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", 
            sessionRole: session.role)
    }
}
```
---

```swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let store = ShapeShifterEnv()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, 
        options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let rootView = ShapeShifterRootView().environmentObject(store)
            window.rootViewController = UIHostingController(rootView: rootView)
            self.window = window
            window.makeKeyAndVisible()
            // undo manager is created only when the window is shown
            store.undoManager = window.undoManager
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

Warts

  • Compiler error red herrings
  • Missing controls (`UICollectionView`)
  • Limit of 10 controls per `@ViewBuilder`
  • Lack of complex control flow statements in `@ViewBuilder`
  • Excess code-completion on generic views

---

## Compiler Error Examples:

#### `Type of expression is ambiguous without more context`
#### `Function declares an opaque return type, but has no return statements in its body from which to infer an underlying type`
#### `Property definition has inferred type 'some View', involving the 'some' return type of another declaration`
#### `Closure containing control flow statement cannot be used with function builder 'ViewBuilder'`

---

Tips

  • Break up large views
  • Keep view construction quick

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

