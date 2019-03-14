import Cocoa

print("Hi, I'm Marc. Code at: https://github.com/glimpseio/Presentations")

struct RGBAColor : Equatable, Codable {
    var red, green, blue, alpha: CGFloat
}

var color = RGBAColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
color.red // direct property access

var redGetter: (RGBAColor) -> (CGFloat) = { $0.red }
// or: func redGetter(_ color: RGBAColor) { return color.red }

redGetter(color) // deferred property access

let redKP = \RGBAColor.red // unqualified KeyPath declaration
let greenKP: WritableKeyPath<RGBAColor, CGFloat> = \RGBAColor.green
let blueKP: WritableKeyPath<RGBAColor, CGFloat> = \.blue

color[keyPath: redKP] // keypath-related property access
color[keyPath: redKP] = 0.25 // assignment to a WritableKeyPath
color // color takes the new value

let colorRO = color
colorRO[keyPath: redKP] // the WritableKeyPath can still red…
// colorRO[keyPath: redKP] = 0.25 // but it cannot write: “cannot assign to immutable expression of type 'CGFloat'”


extension RGBAColor {
    var rgba: Int {
        get {
            return (Int(red * 255) << 24)
                + (Int(green * 255) << 16)
                + (Int(blue * 255) << 8)
                + Int(alpha * 255)
        }

        set {
            self.red = CGFloat(newValue >> 24 & 0xFF) / 255.0
            self.green = CGFloat(newValue >> 16 & 0xFF) / 255.0
            self.blue = CGFloat(newValue >> 8 & 0xFF) / 255.0
            self.alpha = CGFloat(newValue & 0xFF) / 255.0
        }
    }
}

color.rgba = 0xFFFFFFFF // white
(color.red, color.green, color.blue, color.alpha)

color.rgba = 0x000000FF // black
(color.red, color.green, color.blue, color.alpha)

let rgbaKP = \RGBAColor.rgba
color[keyPath: rgbaKP] = 0xF0F8FFFF // aliceblue
(color.red, color.green, color.blue, color.alpha)

struct Shape : Equatable, Codable {
    var points: [CGPoint]
    var stroke, fill: RGBAColor?
}

var square = Shape(points: [
    CGPoint(x: -1, y: -1),
    CGPoint(x: 1, y: -1),
    CGPoint(x: 1, y: 1),
    CGPoint(x: -1, y: 1)
    ], stroke: .none, fill: RGBAColor(red: 1, green: 0, blue: 0, alpha: 1))

var triangle = Shape(points: [
    CGPoint(x: 0, y: -1),
    CGPoint(x: 1, y: 1),
    CGPoint(x: -1, y: 1)
    ], stroke: .none, fill: RGBAColor(red: 0, green: 0, blue: 1, alpha: 1))

//let shapeAlpha: WritableKeyPath<Shape, CGFloat?> = \Shape.fill?.alpha
let shapeAlpha: KeyPath<Shape, CGFloat?> = \Shape.fill?.alpha

let transparency: CGFloat? = square[keyPath: shapeAlpha]

// square[keyPath: shapeAlpha] = 0.5 // error: cannot assign to immutable expression of type 'CGFloat?'


let shapeAlphaForced: WritableKeyPath<Shape, CGFloat> = \Shape.fill!.alpha
square[keyPath: shapeAlphaForced] = 0.5
square.fill = nil
// square[keyPath: shapeAlphaForced] = 0.999 // crash!

protocol Defaultable {
    init()
}

extension RGBAColor : Defaultable {
    init() { self.init(red: 0, green: 0, blue: 0, alpha: 1) }
}

extension Optional where Wrapped : Defaultable {
    var defaulted: Wrapped {
        get { return self ?? Wrapped.init() }
        set { self = .some(newValue) }
    }
}

let shapeAlphaDefaulted: WritableKeyPath<Shape, CGFloat> = \Shape.fill.defaulted.alpha

let redness2: CGFloat = square[keyPath: shapeAlphaDefaulted]

square[keyPath: shapeAlphaDefaulted] /= 2

let redness3: CGFloat = square[keyPath: shapeAlphaDefaulted]


struct Layer : Equatable, Codable {
    let id: UUID = UUID()
    var name: String
    var shapes: [Shape]
    var sublayers: [Layer]
}

protocol Tree {
    associatedtype Node
    static var childrenKeyPath: WritableKeyPath<Node, [Node]> { get }
}

extension Layer : Tree {
    static let childrenKeyPath = \Layer.sublayers
}


extension Tree where Node == Self {
    /// `treeChildren` simply queries the keyPath to the local children
    var treeChildren: [Self] {
        get { return self[keyPath: Self.childrenKeyPath] }
        set { self[keyPath: Self.childrenKeyPath] = newValue }
    }

    /// Retruns a flattened depth-first array of all the tree elements
    func flattened() -> [Self] {
        return [self] + treeChildren.flatMap({ $0.flattened() })
    }
}

var layer = Layer(name: "Top Layer", shapes: [], sublayers: [])
layer.sublayers.append(Layer(name: "Square", shapes: [square], sublayers: []))
layer.sublayers.append(Layer(name: "Triangle", shapes: [triangle], sublayers: []))


// Aside: classes work too, but keypaths are ReferenceWritableKeyPath

extension NSView : Tree {
    static let childrenKeyPath = \NSView.subviews as WritableKeyPath
}

extension NSViewController : Tree {
    static let childrenKeyPath = \NSViewController.children as WritableKeyPath
}

//extension CALayer : Tree {
//    static let childrenKeyPath = \CALayer.sublayers
//}

extension CALayer : Tree {
    private var sublayersArray: [CALayer] {
        get { return self.sublayers ?? [] }
        set { self.sublayers = newValue.isEmpty ? nil : newValue }
    }

    static var childrenKeyPath = \CALayer.sublayersArray as WritableKeyPath
}

layer.flattened().sorted(by: { (layer1, layer2) -> Bool in
    return layer1.name < layer2.name
})

extension Sequence {
    /// Returns this sequence sorted by the given keypath of the element
    func sorted<T: Comparable>(byKey keyPath: KeyPath<Element, T>) -> [Element] {
        return self.sorted(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
    }
}

var layers = layer.flattened().sorted(byKey: \.name)


extension Sequence {
    /// Projects through the specified keyPath, retruning an array of projected elements for this item
    subscript<T>(projecting keyPath: KeyPath<Element, T>) -> [T] {
        return self.map { $0[keyPath: keyPath] }
    }

    /// Selects the set of destinations of the keyPath as a Set
    subscript<T>(uniquing keyPath: KeyPath<Element, T>) -> Set<T> where T : Hashable {
        return Set(self[projecting: keyPath])
    }
}

extension MutableCollection {
    /// Change each element of the collection with the result of the given block
    mutating func change(with block: (Element) -> (Element)) {
        indices.forEach { i in self[i] = block(self[i]) }
    }
}

extension MutableCollection {
    /// Projects through the specified keyPath
    subscript<T>(projecting keyPath: WritableKeyPath<Element, T>) -> [T] {
        get {
            return self.map { $0[keyPath: keyPath] }
        }

        set {
            zip(indices, newValue).forEach { i, value in self[i][keyPath: keyPath] = value }
        }
    }
}

layers[projecting: \.shapes[projecting: \.fill.defaulted.alpha]]

layers[projecting: \.shapes[projecting: \.fill.defaulted.alpha]].change { $0.change { $0 /2 } }

layers[projecting: \.shapes[projecting: \.fill.defaulted.alpha]]

extension MutableCollection {
    /// Selects the set of destinations of the keyPath; setting an empty set will be a no-op, and
    /// setting with multiple values will assign one random member of the set as the value for all the paths.
    subscript<T>(condensing keyPath: WritableKeyPath<Element, T>) -> Set<T> where T : Hashable {
        get {
            return Set(self[projecting: keyPath])
        }

        set {
            guard let item = newValue.first else { return }
            self[projecting: keyPath].replaceSubrange(0..<self.count, with: Array(repeating: item, count: self.count))
        }
    }
}

layers[condensing: \.shapes[condensing: \.fill.defaulted.alpha]] = [[0.5]]
layers.map({ $0.name })
layers.flatMap({ $0.shapes }).flatMap({ $0.points })


print("PG Done: \(Date())")
