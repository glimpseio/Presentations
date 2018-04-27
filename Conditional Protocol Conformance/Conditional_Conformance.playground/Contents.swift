
var x: Set<Optional<Int>> = []
x.insert(.none)
x.insert(1)
x


///// A type that is either a T or a U
///// A type that is either a T or a U, requiring that both types be equatable
//public enum Either<T, U> : Equatable where T: Equatable, U: Equatable {
//    case left(T)
//    case right(U)
//}
//
//let x: Either<String, Int> = .left("Foo")
//let y: Either<String, Int> = .right(2)
//let z: Either<String, Int> = .left("Foo")
//
//x == y // true
//x == z // false
//
//
//let xs = [x]
//let ys = [y]
//let zs = [z]
//
//
//
//xs == ys
//xs == zs
//
//
//let xos: Array<Optional<Either<String, Int>>> = [x, nil]
//let yos = [y, nil]
//let zos = [z, nil]
//
//
//xos == yos
//xos == zos

//extension Either : Hashable where T: Hashable, U: Hashable {
//    public var hashValue: Int {
//        switch self {
//        case .left(let x): return x.hashValue
//        case .right(let y): return y.hashValue
//        }
//    }
//}

extension Optional : Hashable where Wrapped : Hashable {
    public var hashValue: Int {
        switch self {
        case .some(let x): return x.hashValue
        case .none: return 0
        }
    }
}

//let xot: Set<Optional<Either<String, Int>>> = Set(arrayLiteral: x, nil)
//let yot = Set(arrayLiteral: y, nil)
//let zot = Set(arrayLiteral: z, nil)
//
//
//xot == yot // false
//xot == zot // true




//(1, 2.2, "X", "Y", "Z", true) == (1, 2.2, "X", "Y", "Z", true)
//(1, 2.2, "X", "Y", "Z", true, false) == (1, 2.2, "X", "Y", "Z", true, false)


//struct Cat {
//    let name: String
//    let whiskers: Int
//}
//
//extension Cat: Equatable, Hashable {
//
//}
//
//Cat(name: "Meowly", whiskers: 12) == Cat(name: "Meowly", whiskers: 13)
//Cat(name: "Meowly", whiskers: 12).hashValue
//Cat(name: "Meowly", whiskers: 13).hashValue



//extension Either : Equatable where T: Equatable, U: Equatable, T == U {
//    public static func ==(lhs: Either<T, U>, rhs: Either<T, U>) -> Bool {
//        switch (lhs, rhs) {
//        case (.right(let a), .right(let b)): return a == b
//        case (.left(let a), .left(let b)): return a == b
//        case (.right(let a), .left(let b)): return a == b
//        case (.left(let a), .right(let b)): return a == b
//        }
//    }
//}
//
//extension Either : Equatable where T: Equatable, U: Equatable {
//    public static func ==(lhs: Either<T, U>, rhs: Either<T, U>) -> Bool {
//        switch (lhs, rhs) {
//        case (.right(let a), .right(let b)): return a == b
//        case (.left(let a), .left(let b)): return a == b
//        case (.right, .left), (.left, .right): return false
//        }
//    }
//}
//
//Either<Int, Int>.left(1) == Either<Int, Int>.right(1)
//Either<Int, String>.left(1) == Either<Int, String>.right("Foo")



//protocol Summarizable {
//    func summary() -> String
//}
//
//extension String : Summarizable {
//    func summary() -> String {
//        return self
//    }
//}
//
//import Foundation
//
//extension NSNumber : Summarizable {
//    func summary() -> String {
//        return NumberFormatter.localizedString(from: self, number: NumberFormatter.Style.spellOut)
//    }
//}
//
//extension Int : Summarizable {
//    func summary() -> String {
//        return (self as NSNumber).summary()
//    }
//}
//
//(5).summary() // "five"
//
//extension Double : Summarizable {
//    func summary() -> String {
//        return (self as NSNumber).summary()
//    }
//}
//
//(5.5).summary() // "five point five"
//
//extension Array : Summarizable where Element : Summarizable {
//    func summary() -> String {
//        return map({ $0.summary() }).joined(separator: ", ")
//    }
//}
//
//[1.1, 2.2, 3.3].summary() // "one point one, two point two, three point three"
//
//extension Optional : Summarizable where Wrapped : Summarizable {
//    func summary() -> String {
//        switch self {
//        case .none: return "nothing"
//        case .some(let x): return x.summary()
//        }
//    }
//}
//
//[Optional<Int>.some(4), 5, nil].summary() // "four, five, nothing"
//
//
