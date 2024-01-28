import Combine
import XCTest
@testable import SearchFormApp

final class TripSearchResultsViewModelTests: XCTestCase {
    private var viewModel: TripSearchResultsViewModel<GetTripsRequest>!
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        viewModel = TripSearchResultsViewModel(
            tripSearchModel: TripSearchModelMocks.barcelonaMadridTrip,
            apiClient: TripSearchResultsViewModelMocks.apiClient,
            request: GetTripsRequest()
        )
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testLabelsFilled() {
        XCTAssertNotEqual(viewModel.startDateLabel, "")
        XCTAssertNotEqual(viewModel.endDateLabel, "")
        XCTAssertNotEqual(viewModel.label(for: TripFareViewModelMocks.adult), "")
        XCTAssertNotEqual(viewModel.value(for: TripFareViewModelMocks.adult, with: TripSearchResultsViewModelMocks.currency), "")
        XCTAssertNotEqual(viewModel.noFareLabel, "")
        XCTAssertNotEqual(viewModel.searchResultsTitle, "")
        XCTAssertNotEqual(viewModel.confirmButtonLabel, "")
        XCTAssertNotEqual(viewModel.noResultsLabel, "")
    }
    
    func testGivenASuccessfulTriggerOnTripSearchWhenCheckingReturnedResultsThenITShouldBeFilled() {
        let expect = self.expectation(description: "results")
        
        _ = viewModel.publisher.sink { [weak self] viewModel in
            guard let self = self else { return }
            
            MockURLProtocol.requestHandler = { request in
                guard let url = request.url,
                      let data = try? JSONEncoder().encode(TripResponseModelMocks.validResponse)
                else {
                    throw MockError.generic
                }
                
                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, data)
            }
            
            viewModel.publisher.sink { _ in
            } receiveValue: { result in
                XCTAssertEqual(result.count, 1)
                expect.fulfill()
            }
            .store(in: &self.cancellables)
        }
        
        self.wait(for: [expect], timeout: 1)
    }
    
    func testGivenASuccessfulTriggerOnTripSearchButTheresNoFlightDatesWhenCheckingReturnedResultsThenITShouldThrowAnException() {
        let expect = self.expectation(description: "results")
        
        _ = viewModel.publisher.sink { [weak self] viewModel in
            guard let self = self else { return }
            
            MockURLProtocol.requestHandler = { request in
                guard let url = request.url,
                      let data = try? JSONEncoder().encode(TripResponseModelMocks.noDates)
                else {
                    throw MockError.generic
                }
                
                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, data)
            }
            
            viewModel.publisher.sink { _ in
            } receiveValue: { result in
                XCTAssertEqual(result.count, 0)
                expect.fulfill()
            }
            .store(in: &self.cancellables)
        }
        
        self.wait(for: [expect], timeout: 1)
    }
    
    func testGivenASuccessfulTriggerOnTripSearchButTheresNotEnoughFlightDatesWhenCheckingReturnedResultsThenITShouldThrowAnException() {
        let expect = self.expectation(description: "results")
        
        _ = viewModel.publisher.sink { [weak self] viewModel in
            guard let self = self else { return }
            
            MockURLProtocol.requestHandler = { request in
                guard let url = request.url,
                      let data = try? JSONEncoder().encode(TripResponseModelMocks.tooLittleDates)
                else {
                    throw MockError.generic
                }
                
                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, data)
            }
            
            viewModel.publisher.sink { _ in
            } receiveValue: { result in
                XCTAssertEqual(result.count, 0)
                expect.fulfill()
            }
            .store(in: &self.cancellables)
        }
        
        self.wait(for: [expect], timeout: 1)
    }
    
    func testGivenASuccessfulTriggerOnTripSearchButTheresTooManyFlightDatesWhenCheckingReturnedResultsThenITShouldThrowAnException() {
        let expect = self.expectation(description: "results")
        
        _ = viewModel.publisher.sink { [weak self] viewModel in
            guard let self = self else { return }
            
            MockURLProtocol.requestHandler = { request in
                guard let url = request.url,
                      let data = try? JSONEncoder().encode(TripResponseModelMocks.tooManyDates)
                else {
                    throw MockError.generic
                }
                
                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, data)
            }
            
            viewModel.publisher.sink { _ in
            } receiveValue: { result in
                XCTAssertEqual(result.count, 0)
                expect.fulfill()
            }
            .store(in: &self.cancellables)
        }
        
        self.wait(for: [expect], timeout: 1)
    }
    
    func testGivenAUnsuccessfulTriggerOnTripSearchWhenCheckingReturnedResultsThenITShouldThrowAnException() {
        let expect = self.expectation(description: "results")
        
        _ = viewModel.publisher.sink { [weak self] viewModel in
            guard let self = self else { return }
            
            MockURLProtocol.requestHandler = { _ in
                throw MockError.generic
            }
            
            viewModel.publisher.sink { completion in
                switch completion {
                case .failure:
                    XCTAssertTrue(true)
                    expect.fulfill()
                case .finished:
                    XCTFail("not supposed to get here")
                }
            } receiveValue: { _ in
            }
            .store(in: &self.cancellables)
        }
        
        self.wait(for: [expect], timeout: 1)
    }
}
