import Foundation

public protocol Dividing {
    func run(arguments: [String]) throws -> Double
}

extension Divider: Dividing {}

public struct DivisionCLI {
    let divider: any Dividing

    public init() {
        self.divider = Divider()
    }

    init(divider: any Dividing) {
        self.divider = divider
    }

    public func run(
        arguments: [String],
        writeStdout: (String) -> Void,
        writeStderr: (String) -> Void
    ) -> Int32 {
        do {
            let result = try divider.run(arguments: arguments)
            writeStdout("\(result)\n")
            return EXIT_SUCCESS
        } catch let error as DivisionError {
            writeStderr("\(error.description)\n")
            return EXIT_FAILURE
        } catch {
            writeStderr("Unexpected error: \(error)\n")
            return EXIT_FAILURE
        }
    }
}
