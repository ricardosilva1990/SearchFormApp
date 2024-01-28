import XCTest
@testable import SearchFormApp

final class NilDestStationPickerViewModelTests: XCTestCase {
    private var viewModel: DestinationStationPickerViewModel!

    override func setUpWithError() throws {
        viewModel = DestinationStationPickerViewModel()
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

final class FilledDestStationPickerViewModelTests: XCTestCase {
    private var viewModel: DestinationStationPickerViewModel!

    override func setUpWithError() throws {
        viewModel = DestinationStationPickerViewModel(selectedStation: StationViewModelMocks.barcelona)
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
