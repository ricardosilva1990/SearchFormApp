import XCTest
@testable import SearchFormApp

final class AdultNumberViewModelTests: XCTestCase {
    private var viewModel: AdultNumberViewModel!
    
    override func setUpWithError() throws {
        viewModel = AdultNumberViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testDefaultValues() {
        XCTAssertEqual(viewModel.minimumNumber, 1)
        XCTAssertEqual(viewModel.maximumNumber, 6)
    }
    
    func testLabelsFilled() {
        XCTAssertNotEqual(viewModel.label, "")
    }
    
    func testGivenTheDefaultValuesWhenCheckingRangeThenItShouldReturnAnAscendingRange() {
        XCTAssertEqual(viewModel.range, 1...6)
    }
}
