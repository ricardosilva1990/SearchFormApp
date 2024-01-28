import XCTest
@testable import SearchFormApp

final class NilOriginStationPickerViewModelTests: XCTestCase {
    private var viewModel: OriginStationPickerViewModel!

    override func setUpWithError() throws {
        viewModel = OriginStationPickerViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testDefaultValues() {
        XCTAssertNil(viewModel.selectedStation)
    }
    
    func testLabelsFilled() {
        XCTAssertNotEqual(viewModel.title, "")
    }
}

final class FilledOriginStationPickerViewModelTests: XCTestCase {
    private var viewModel: OriginStationPickerViewModel!

    override func setUpWithError() throws {
        viewModel = OriginStationPickerViewModel(selectedStation: StationViewModelMocks.barcelona)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testDefaultValues() {
        XCTAssertEqual(viewModel.selectedStation, StationViewModelMocks.barcelona)
    }
    
    func testLabelsFilled() {
        XCTAssertNotEqual(viewModel.title, "")
    }
}
