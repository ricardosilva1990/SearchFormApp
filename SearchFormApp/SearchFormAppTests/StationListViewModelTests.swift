import Combine
import XCTest
@testable import SearchFormApp

final class StationListViewModelTests: XCTestCase {
    private var viewModel: StationListViewModel<GetStationsRequest>!
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        viewModel = StationListViewModel(
            title: StationListViewModelMocks.title, apiClient: StationListViewModelMocks.apiClient, request: GetStationsRequest()
        )
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testDefaultValues() {
        XCTAssertTrue(viewModel.stationArray.isEmpty)
    }
    
    func testLabelsFilled() {
        XCTAssertNotEqual(viewModel.titleLabel(for: StationViewModelMocks.barcelona), "")
        XCTAssertNotEqual(viewModel.titleLabel(for: nil), "")
        XCTAssertNotEqual(viewModel.noResultsLabel, "")
    }
    
    func testGivenASuccessfulTriggerOnFetchStationListWhenCheckingStationListViewModelThenItShouldBeFilled() {
        XCTAssertTrue(viewModel.stationArray.isEmpty)
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url,
                  let data = try? JSONEncoder().encode(StationListModelMocks.list)
            else {
                throw MockError.generic
            }
        
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        let expect = expectation(description: "results")
        viewModel.$stationArray
            .dropFirst()
            .sink { result in
                XCTAssertEqual(result.count, StationListModelMocks.list.stations.count)
                expect.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchStationList()
        wait(for: [expect], timeout: 1)
    }
    
    func testGivenAUnsuccessfulTriggerOnFetchStationListWhenCheckingStationListViewModelThenItShouldThrowException() {
        XCTAssertTrue(viewModel.stationArray.isEmpty)
        
        MockURLProtocol.requestHandler = { _ in
            throw MockError.generic
        }
        
        let expect = expectation(description: "results")
        viewModel.$stationArray
            .dropFirst()
            .sink { result in
                XCTAssertTrue(result.isEmpty)
                expect.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchStationList()
        wait(for: [expect], timeout: 1)
    }
}
