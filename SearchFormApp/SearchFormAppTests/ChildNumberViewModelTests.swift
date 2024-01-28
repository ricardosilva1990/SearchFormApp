import XCTest
@testable import SearchFormApp

final class ChildNumberViewModelTests: XCTestCase {
    private var viewModel: ChildNumberViewModel!
    
    override func setUpWithError() throws {
        viewModel = ChildNumberViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testDefaultValues() {
        XCTAssertEqual(viewModel.minimumNumber, 0)
        XCTAssertEqual(viewModel.maximumNumber, 6)
    }
    
    func testLabelsFilled() {
        XCTAssertNotEqual(viewModel.label, "")
    }
    
    func testGivenTheDefaultValuesWhenCheckingRangeThenItShouldReturnAnAscendingRange() {
        XCTAssertEqual(viewModel.range, 0...6)
    }
}
