//  ShapeShifter.swift
//  SwiftUIShapeShifter
//
//  Created by Marc Prud'hommeaux on 7/30/19.

// MARK: Data Model
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

// MARK: Views
struct ShapeShifterRootView: SwiftUI.View {
    @EnvironmentObject var env: ShapeShifterEnv

    var body: some SwiftUI.View {
        HStack {
            ShapeView(model: $env.model).scaledToFit().padding()
            Divider()
            ShapeInspector(model: $env.model)
        }
    }
}

struct ShapeView: SwiftUI.View {
    @Binding var model: ShapeShifterModel

    var body: some SwiftUI.View {
        return ZStack {
            if model.kind == .circle {
                Circle().fill(model.fill.color)
                Circle().strokeBorder(model.outline.color, lineWidth: CGFloat(model.outlineWidth))
            } else if model.kind == .square {
                Rectangle().fill(model.fill.color)
                Rectangle().strokeBorder(model.outline.color, lineWidth: CGFloat(model.outlineWidth))
            }
        }
    }
}

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

struct UndoRedoButtons: SwiftUI.View {
    @EnvironmentObject var env: ShapeShifterEnv

    var body: some SwiftUI.View {
        HStack {
            Button("Undo") { self.env.undoManager?.undo() }
                .disabled(self.env.undoManager?.canUndo == false)
                .font(.title)
                .buttonStyle(.default)

            Spacer()

            Button("Redo") { self.env.undoManager?.redo() }
                .disabled(self.env.undoManager?.canRedo == false)
                .font(.title)
                .buttonStyle(.default)

        }.padding()
    }
}

/// A collection of sliders that modify a `ShapeShifterModel.HSL` model object.
struct HSLSliders: SwiftUI.View {
    let label: String
    @Binding var color: ShapeShifterModel.HSL
    @Binding var shown: Bool

    var body: some SwiftUI.View {
        Section(header: Button(action: { self.$shown.value.toggle() }, label: { Text(label) }).font(.title), footer: SwatchPicker(color: $color)) {
            if shown {
                PercentSlider(label: "Hue", value: $color.hue)
                PercentSlider(label: "Saturation", value: $color.saturation)
                PercentSlider(label: "Brightness", value: $color.brightness)
                PercentSlider(label: "Opacity", value: $color.opacity)
            }
        }
    }
}

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

#if DEBUG
struct ShapeShifterRootView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeShifterRootView()
            .environmentObject(ShapeShifterEnv())
            .previewDevice("iPhone SE")
            .previewLayout(.sizeThatFits)
    }
}
#endif

import Combine

/// The environment in which a `ShapeShifterModel` can be contained.
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
            // inform listeners of changes
            willChange.send(newModel)
        }
    }
}

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let store = ShapeShifterEnv()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting session: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: session.role)
    }
}