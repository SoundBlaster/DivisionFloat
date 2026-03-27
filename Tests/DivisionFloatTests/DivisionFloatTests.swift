import Testing
@testable import DivisionCore

private struct FailingDivider: Dividing {
    struct UnknownFailure: Error {}

    func run(arguments: [String]) throws -> Double {
        throw UnknownFailure()
    }
}

struct DivisionFloatTests {
    let divider = Divider()
    let cli = DivisionCLI()

    @Test func dividesTwoFloats() throws {
        let result = try divider.divide(10.5, by: 2.0)
        #expect(result == 5.25)
    }

    @Test func throwsOnDivisionByZero() {
        #expect(throws: DivisionError.divisionByZero) {
            try divider.divide(10, by: 0)
        }
    }

    @Test func parsesAndRuns() throws {
        let result = try divider.run(arguments: ["9", "4.5"])
        #expect(result == 2)
    }

    @Test func throwsOnInvalidArgumentCount() {
        #expect(throws: DivisionError.invalidArgumentCount) {
            try divider.run(arguments: ["5"])
        }
    }

    @Test func throwsOnInvalidFirstFloat() {
        #expect(throws: DivisionError.invalidFloat("x")) {
            try divider.run(arguments: ["x", "1"])
        }
    }

    @Test func throwsOnInvalidSecondFloat() {
        #expect(throws: DivisionError.invalidFloat("y")) {
            try divider.run(arguments: ["1", "y"])
        }
    }

    @Test func cliPrintsResultAndSuccessStatus() {
        var stdout = ""
        var stderr = ""

        let status = cli.run(
            arguments: ["6", "3"],
            writeStdout: { stdout += $0 },
            writeStderr: { stderr += $0 }
        )

        #expect(status == Int32(0))
        #expect(stdout == "2.0\n")
        #expect(stderr.isEmpty)
    }

    @Test func cliPrintsUserErrorAndFailureStatus() {
        var stdout = ""
        var stderr = ""

        let status = cli.run(
            arguments: ["7", "0"],
            writeStdout: { stdout += $0 },
            writeStderr: { stderr += $0 }
        )

        #expect(status == Int32(1))
        #expect(stdout.isEmpty)
        #expect(stderr == "Division by zero is not allowed\n")
    }

    @Test func cliPrintsUnexpectedErrorAndFailureStatus() {
        var stdout = ""
        var stderr = ""

        let failingCLI = DivisionCLI(divider: FailingDivider())
        let status = failingCLI.run(
            arguments: ["any", "value"],
            writeStdout: { stdout += $0 },
            writeStderr: { stderr += $0 }
        )

        #expect(status == Int32(1))
        #expect(stdout.isEmpty)
        #expect(stderr.contains("Unexpected error:"))
    }
}
