import XCTest

final class SmokeUITests: XCTestCase {
    func testLaunchAndTabs() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.tabBars.buttons["Catálogo"].exists)
    }
}
