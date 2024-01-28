import XCTest
@testable import SearchFormApp

final class SearchFormViewModelTests: XCTestCase {
    private var viewModel: SearchFormViewModel!
    
    override func setUpWithError() throws {
        viewModel = SearchFormViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testDefaultValues() {
        XCTAssertNil(viewModel.originStation)
        XCTAssertNil(viewModel.destinationStation)
        XCTAssertNotNil(viewModel.departureDate)
        XCTAssertEqual(viewModel.adult, 1)
        XCTAssertEqual(viewModel.teen, 0)
        XCTAssertEqual(viewModel.child, 0)
    }
    
    func testLabelsFilled() {
        XCTAssertNotEqual(viewModel.stationSectionLabel, "")
        XCTAssertNotEqual(viewModel.originStationLabel, "")
        XCTAssertNotEqual(viewModel.destinationStationLabel, "")
        XCTAssertNotEqual(viewModel.departureDateLabel, "")
        XCTAssertNotNil(viewModel.departureDateMinimum)
        XCTAssertNotEqual(viewModel.passengerNumberSectionLabel, "")
        XCTAssertNotEqual(viewModel.searchButtonLabel, "")
        XCTAssertNotEqual(viewModel.searchFormTitle, "")
    }
}

// MARK: - Tests on 'searchable'
extension SearchFormViewModelTests {
    func testGivenNoOriginNorDestinationStationWhenCheckingSearchableThenReturnsFalse() {
        viewModel.originStation = nil
        viewModel.destinationStation = nil
        
        XCTAssertFalse(viewModel.searchable)
    }
    
    func testGivenNoOriginStationWhenCheckingSearchableThenReturnsFalse() {
        viewModel.originStation = nil
        viewModel.destinationStation = StationViewModelMocks.barcelona
        
        XCTAssertFalse(viewModel.searchable)
    }
    
    func testGivenNoDestinationStationWhenCheckingSearchableThenReturnsFalse() {
        viewModel.originStation = StationViewModelMocks.madrid
        viewModel.destinationStation = nil
        
        XCTAssertFalse(viewModel.searchable)
    }
    
    func testGivenSameOriginAndDestinationStationWhenCheckingSearchableThenReturnsFalse() {
        viewModel.originStation = StationViewModelMocks.madrid
        viewModel.destinationStation = StationViewModelMocks.madrid
        
        XCTAssertFalse(viewModel.searchable)
    }
    
    func testGivenDifferentOriginAndDestinationStationWhenCheckingSearchableThenReturnsTrue() {
        viewModel.originStation = StationViewModelMocks.madrid
        viewModel.destinationStation = StationViewModelMocks.barcelona
        
        XCTAssertTrue(viewModel.searchable)
    }
}

// MARK: - Tests on 'tripSearchModel'
extension SearchFormViewModelTests {
    func testGivenNoOriginStationWhenCheckingTripSearchModelThenItShouldThrowException() throws {
        viewModel.originStation = StationViewModelMocks.barcelona
        viewModel.departureDate = Date()
        viewModel.adult = 1
        viewModel.teen = 1
        viewModel.child = 1
        
        do {
            _ = try viewModel.tripSearchModel
            XCTFail("not supposed to get here")
        } catch let error as ConversionError {
            XCTAssertEqual(error, .stationNotFilled)
        }
    }
    
    func testGivenNoDestinationStationWhenCheckingTripSearchModelThenItShouldThrowException() throws {
        viewModel.destinationStation = StationViewModelMocks.barcelona
        viewModel.departureDate = Date()
        viewModel.adult = 1
        viewModel.teen = 1
        viewModel.child = 1
        
        do {
            _ = try viewModel.tripSearchModel
            XCTFail("not supposed to get here")
        } catch let error as ConversionError {
            XCTAssertEqual(error, .stationNotFilled)
        }
    }
    
    func testGivenValidStationsWhenCheckingTripSearchModelThenItShouldReturnTheResultingViewModel() throws {
        viewModel.originStation = StationViewModelMocks.madrid
        viewModel.destinationStation = StationViewModelMocks.barcelona
        viewModel.departureDate = Date()
        viewModel.adult = 2
        viewModel.teen = 2
        viewModel.child = 2
        
        let tripSearchModel = try viewModel.tripSearchModel
        XCTAssertEqual(tripSearchModel.origin, viewModel.originStation?.code)
        XCTAssertEqual(tripSearchModel.destination, viewModel.destinationStation?.code)
        XCTAssertEqual(tripSearchModel.departureDate, viewModel.departureDate)
        XCTAssertEqual(tripSearchModel.adultNumber, viewModel.adult)
        XCTAssertEqual(tripSearchModel.teenNumber, viewModel.teen)
        XCTAssertEqual(tripSearchModel.childNumber, viewModel.child)
    }
}
