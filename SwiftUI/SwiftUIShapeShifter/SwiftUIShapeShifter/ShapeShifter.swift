//  SwiftUIShapeShifter
//  Created by Marc Prud'hommeaux on 7/30/19.
//  https://github.com/glimpseio/Presentations/blob/master/SwiftUI/SwiftUIShapeShifter/SwiftUIShapeShifter/ShapeShifter.swift

/// A model of a shape with a fill and an outline color that can be serialized to data.
struct DataModel : Hashable, Codable {
    var kind = ShapeKind.circle
    var fill = HSB(hue: 0.66)
    var outline = HSB(hue: 0.08)
    var outlineWidth = 15.0

    /// A model of a color using hue / saturation / brightness + opacity
    struct HSB : Hashable, Codable {
        var hue = 0.0
        var saturation = 1.0
        var brightness = 1.0
        var opacity = 1.0
    }

    /// A Kind of Shape
    enum ShapeKind : String, Hashable, Codable, CaseIterable {
        case square, circle
    }
}

import SwiftUI

struct ShapeShifterRootView: SwiftUI.View {
    @EnvironmentObject var env: DataModel.Container

    var body: some SwiftUI.View {
        VStack {
            ShapePreview(model: $env.model).scaledToFit().padding()
            ShapeInspector(model: $env.model)
        }
    }
}

struct ShapePreview: SwiftUI.View {
    @Binding var model: DataModel

    var body: some SwiftUI.View {
        return ZStack {
            if model.kind == .circle { // switch statements are unsupported in @ViewBuilder!
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
    @Binding var model: DataModel
    @State private var showFill = false
    @State private var showOutline = false

    var body: some SwiftUI.View {
        VStack {
            Picker("Kind", selection: $model.kind) {
                ForEach(DataModel.ShapeKind.allCases, id: \.self) { kind in
                    Text(kind.rawValue.capitalized).tag(kind)
                }
            }.pickerStyle(SegmentedPickerStyle())

            Form {
                HSBSliders(label: "Fill Color", color: $model.fill, shown: $showFill)
                HSBSliders(label: "Border Color", color: $model.outline, shown: $showOutline)
                Slider(value: $model.outlineWidth, in: 0...100).padding(15)
            }

            UndoRedoButtons().padding()
        }
    }
}

/// A collection of sliders that modify a `DataModel.HSB` model object.
struct HSBSliders: SwiftUI.View {
    let label: String
    @Binding var color: DataModel.HSB
    @Binding var shown: Bool

    var body: some SwiftUI.View {
        Section(header: Button(action: { self.$shown.wrappedValue.toggle() }, label: { Text(label) }).font(.title), footer: SwatchPicker(color: $color)) {
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
    @Binding var color: DataModel.HSB

    var body: some SwiftUI.View {
        HStack {
            ForEach(DataModel.HSB.swatches, id: \.self) { swatch in
                Button(action: {
                    self.color = swatch
                }, label: {
                    Rectangle().fill(swatch.color).aspectRatio(contentMode: .fit)
                }).border(Color.primary, width: self.color == swatch ? 3 : 0)
            }
        }
    }
}

extension DataModel.ShapeKind {
    /// Creates a path from the current shape kind
    func createPath() -> SwiftUI.Path {
        switch self {
        case .square: return Path(CGRect(x: 1, y: 1, width: 1, height: 1))
        case .circle: return Path(ellipseIn: CGRect(x: 1, y: 1, width: 1, height: 1))
        }
    }
}

extension DataModel.HSB {
    /// Convert the `HSB` model into a `SwiftUI.Color`
    var color: SwiftUI.Color {
        Color(hue: hue, saturation: saturation, brightness: brightness, opacity: opacity)
    }

    /// Static constants for pre-defined colors
    static let swatches = [
        Self(saturation: 0.00, brightness: 0.00), // black
        Self(hue: 0.08, saturation: 0.66, brightness: 0.60), // brown
        Self(brightness: 1.00), // red
        Self(hue: 0.08), // orange
        Self(hue: 0.16), // yellow
        Self(hue: 0.33), // green
        Self(hue: 0.50), // cyan
        Self(hue: 0.66), // blue
        Self(hue: 0.83), // magenta
        Self(hue: 0.83, brightness: 0.50), // purple
        Self(saturation: 0.00), // white
    ]
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
            Slider(value: $value, in: 0.0...1.0)
            Text("\(value as NSNumber, formatter: Self.percentFormatter)")
        }
    }
}

struct UndoRedoButtons: SwiftUI.View {
    @EnvironmentObject var env: DataModel.Container

    var body: some SwiftUI.View {
        HStack {
            Button("Undo") { self.env.undoManager?.undo() }
                .disabled(self.env.undoManager?.canUndo != true)
            Spacer()
            Button("Redo") { self.env.undoManager?.redo() }
                .disabled(self.env.undoManager?.canRedo != true)

        }
        .font(.title)
        .buttonStyle(DefaultButtonStyle())
    }
}

import Combine

extension DataModel {
    /// Model is persisted to user defaults
    func save(to defaults: UserDefaults = UserDefaults.standard) throws {
        let shapeData = try JSONEncoder().encode(self)
        defaults.set(shapeData, forKey: "shapeData")
        debugPrint("save", String(data: shapeData, encoding: .utf8) ?? "<<ERROR>>")
    }

    mutating func load(from defaults: UserDefaults = UserDefaults.standard) throws -> Bool {
        if let data = defaults.data(forKey: "shapeData") {
            self = try JSONDecoder().decode(Self.self, from: data)
            return true
        } else {
            return false // no saved data to load
        }
    }

    /// A reference container for a DataModel that can publishes changes and handles undo registration
    class Container : Combine.ObservableObject {
        @Published var model = DataModel() {
            willSet { registerUndo(state: self.model) }
            didSet { scheduleSave() }
        }

        /// The undoManager associated with the environment
        var undoManager: UndoManager? = nil

        /// Register a state change with the current UndoManager
        private func registerUndo(state lastModel: DataModel) {
            if let um = self.undoManager, um.isUndoRegistrationEnabled {
                um.registerUndo(withTarget: self) { target in
                    withAnimation(.easeInOut(duration: 0.5)) { // because YOLO
                        target.model = lastModel
                    }
                }
            }
        }

        /// The current outstanding work item to save
        private var saveWorkItem: DispatchWorkItem? = nil

        /// Save the data model to the `UserDefaults` after a delay (with throttling).
        private func scheduleSave(after deadline: DispatchTime = .now() + 2.0) {
            // serialize the data to the `UserDefaults` in the background
            let saveData = self.model
            let item = DispatchWorkItem { try? saveData.save() }
            self.saveWorkItem?.cancel() // cancel any previous save request (e.g., debounce)
            self.saveWorkItem = item
            // save to user defaults in the background
            DispatchQueue.global(qos: .background).asyncAfter(deadline: deadline, execute: item)
        }
    }
}

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting session: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: session.role)
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let store = DataModel.Container()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let _ = try? store.model.load() // load data from defaults, ignoring erros
            let rootView = ShapeShifterRootView().environmentObject(store)
            window.rootViewController = UIHostingController(rootView: rootView)
            self.window = window
            window.makeKeyAndVisible()
            store.undoManager = window.undoManager
        }
    }
}

#if DEBUG
struct ShapeShifterRootView_Previews: PreviewProvider {
    static var previews: some View {
        let env = DataModel.Container()
        env.undoManager = UndoManager()
        return ShapeShifterRootView()
            .environmentObject(env)
            .previewDevice("iPhone SE") // the best device
    }
}
#endif
