import XCTest
@testable import ServiceDeskPlus

final class TicketPriorityTests: XCTestCase {
    func testLabels() {
        XCTAssertEqual(TicketPriority.high.label, "High")
    }
}
