import Foundation

enum DivisionError: Error, Equatable, CustomStringConvertible {
    case invalidArgumentCount
    case invalidFloat(String)
    case divisionByZero

    var description: String {
        switch self {
        case .invalidArgumentCount:
            return "Usage: division-float <dividend> <divisor>"
        case .invalidFloat(let value):
            return "Invalid float value: \(value)"
        case .divisionByZero:
            return "Division by zero is not allowed"
        }
    }
}

struct Divider {
    func divide(_ dividend: Double, by divisor: Double) throws -> Double {
        guard divisor != 0 else {
            throw DivisionError.divisionByZero
        }

        return dividend / divisor
    }

    func run(arguments: [String]) throws -> Double {
        guard arguments.count == 2 else {
            throw DivisionError.invalidArgumentCount
        }

        let dividendText = arguments[0]
        let divisorText = arguments[1]

        guard let dividend = Double(dividendText) else {
            throw DivisionError.invalidFloat(dividendText)
        }

        guard let divisor = Double(divisorText) else {
            throw DivisionError.invalidFloat(divisorText)
        }

        return try divide(dividend, by: divisor)
    }
}
