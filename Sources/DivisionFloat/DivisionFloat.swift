import Foundation
import DivisionCore

@main
struct DivisionFloat {
    static func main() {
        let cli = DivisionCLI()
        Foundation.exit(
            cli.run(
                arguments: Array(CommandLine.arguments.dropFirst()),
                writeStdout: { print($0, terminator: "") },
                writeStderr: { FileHandle.standardError.write(Data($0.utf8)) }
            )
        )
    }
}
