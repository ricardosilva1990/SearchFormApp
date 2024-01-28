import XCTest

final class SearchFormAppUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments += ["-isUITesting"]
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testDefaultViewItemsAreShown() {
        let originStationPicker = app.staticTexts["OriginStationPickerView"]
        let destinationStationPicker = app.staticTexts["DestinationStationPickerView"]
        let stationSectionHeader = app.staticTexts["StationSectionHeader"]
        let departureDateDatePicker = app.datePickers["DepartureDatePicker"]
        let departureDateSectionHeader = app.staticTexts["DepartureDateSectionHeader"]
        let adultPicker = app.steppers["AdultPicker"]
        let teenPicker = app.steppers["TeenPicker"]
        let childPicker = app.steppers["ChildPicker"]
        let passengerPickerSectionHeader = app.staticTexts["PassengerPickerSectionHeader"]
        let searchButton = app.buttons["SearchButton"]

        XCTAssertTrue(originStationPicker.exists)
        XCTAssertTrue(destinationStationPicker.exists)
        XCTAssertTrue(stationSectionHeader.exists)
        XCTAssertTrue(departureDateDatePicker.exists)
        XCTAssertTrue(departureDateSectionHeader.exists)
        XCTAssertTrue(searchButton.exists)
        XCTAssertFalse(searchButton.isEnabled)

        app.swipeUp()   // due to smaller devices

        XCTAssertTrue(adultPicker.exists)
        XCTAssertTrue(teenPicker.exists)
        XCTAssertTrue(childPicker.exists)
        XCTAssertTrue(passengerPickerSectionHeader.exists)
    }
    
    func testSelectOriginStation() {
        app.collectionViews.buttons["OriginStationPickerView-OriginStationPickerView"].tap()
        let searchField = app.navigationBars["Origin Station"].searchFields["Search"]
        searchField.tap()
        searchField.typeText("Barcelona")
        
        let stationCell = app.cells.staticTexts["Barcelona"]
        XCTAssertTrue(stationCell.exists)
        
        stationCell.tap()
        
        XCTAssertTrue(app.buttons["OriginStationPickerView-OriginStationPickerView"].label.contains("Barcelona"))
    }
    
    func testSearchForNonExistingStation() {
        app.collectionViews.buttons["OriginStationPickerView-OriginStationPickerView"].tap()
        let originSearchField = app.navigationBars["Origin Station"].searchFields["Search"]
        originSearchField.tap()
        originSearchField.typeText("zzzzzzz")
        
        let stationCell = app.collectionViews["StationList"].cells["StationName"]
        XCTAssertFalse(stationCell.exists)
    }
    
    func testSelectDestinationStation() {
        app.collectionViews.buttons["DestinationStationPickerView-DestinationStationPickerView"].tap()
        let searchField = app.navigationBars["Destination Station"].searchFields["Search"]
        searchField.tap()
        searchField.typeText("Porto")
        
        let stationCell = app.cells.staticTexts["Porto"]
        XCTAssertTrue(stationCell.exists)
        
        stationCell.tap()
        
        XCTAssertTrue(app.buttons["DestinationStationPickerView-DestinationStationPickerView"].label.contains("Porto"))
    }
    
    func testSelectSameOriginAndDestinationStation() {
        app.collectionViews.buttons["OriginStationPickerView-OriginStationPickerView"].tap()
        let originSearchField = app.navigationBars["Origin Station"].searchFields["Search"]
        originSearchField.tap()
        originSearchField.typeText("Barcelona")
        
        let firstStationCell = app.cells.staticTexts["Barcelona"]
        XCTAssertTrue(firstStationCell.exists)
        
        firstStationCell.tap()
        
        app.collectionViews.buttons["DestinationStationPickerView-DestinationStationPickerView"].tap()
        let destinationSearchField = app.navigationBars["Destination Station"].searchFields["Search"]
        destinationSearchField.tap()
        destinationSearchField.typeText("Barcelona")
        
        let secondStationCell = app.cells.staticTexts["Barcelona"]
        XCTAssertTrue(secondStationCell.exists)
        
        secondStationCell.tap()
        
        let searchButton = app.buttons["SearchButton"]
        XCTAssertFalse(searchButton.isEnabled)
    }
    
    func testPickerDecrementSelection() throws {
        app.swipeUp()
        
        let adultPicker = app.steppers["AdultPicker"]
        let adultPickerText = app.staticTexts["AdultPicker"]
        
        guard let initialValueText = adultPicker.value as? String, let initialValue = Int(initialValueText) else {
            XCTFail("Not supposed to get here")
            return
        }
        
        XCTAssertEqual(initialValueText, adultPickerText.label)
        
        adultPicker.buttons["AdultPicker-Increment"].tap()
        
        guard let finalValueText = adultPicker.value as? String, let finalValue = Int(finalValueText) else {
            XCTFail("Not supposed to get here")
            return
        }
        
        XCTAssertEqual(finalValueText, adultPickerText.label)
        
        XCTAssert(finalValue >= initialValue)
    }
    
    func testPickerIncrementSelection() throws {
        app.swipeUp()
        
        let teenPicker = app.steppers["TeenPicker"]
        let teenPickerText = app.staticTexts["TeenPicker"]
        
        guard let initialValueText = teenPicker.value as? String, let initialValue = Int(initialValueText) else {
            XCTFail("Not supposed to get here")
            return
        }
        
        XCTAssertEqual(initialValueText, teenPickerText.label)
        
        teenPicker.buttons["TeenPicker-Decrement"].tap()
        
        guard let finalValueText = teenPicker.value as? String, let finalValue = Int(finalValueText) else {
            XCTFail("Not supposed to get here")
            return
        }
        
        XCTAssertEqual(finalValueText, teenPickerText.label)
        
        XCTAssert(finalValue <= initialValue)
    }
    
    func testSelectOriginAndDestinationStationsAndPerformSearch() {
        app.collectionViews.buttons["OriginStationPickerView-OriginStationPickerView"].tap()
        let originSearchField = app.navigationBars["Origin Station"].searchFields["Search"]
        originSearchField.tap()
        originSearchField.typeText("Barcelona")
        
        let firstStationCell =  app.cells.staticTexts["Barcelona"]
        XCTAssertTrue(firstStationCell.exists)
        
        firstStationCell.tap()
        
        app.collectionViews.buttons["DestinationStationPickerView-DestinationStationPickerView"].tap()
        let destinationSearchField = app.navigationBars["Destination Station"].searchFields["Search"]
        destinationSearchField.tap()
        destinationSearchField.typeText("Porto")
        
        let secondStationCell = app.cells.staticTexts["Porto"]
        XCTAssertTrue(secondStationCell.exists)
        
        secondStationCell.tap()
        
        let searchButton = app.buttons["SearchButton"]
        XCTAssertTrue(searchButton.isEnabled)
        
        searchButton.tap()
        
        let tripSearchResultList = app.collectionViews["TripSearchResultsList"]
        XCTAssertTrue(tripSearchResultList.exists)
        
        let tripSectionLabel = app.staticTexts["TripSectionLabel"]
        let tripStartDateLabel = app.staticTexts["TripStartDateLabel"]
        let tripStartDateValueText = app.staticTexts["TripStartDateValueText"]
        let tripEndDateLabel = app.staticTexts["TripEndDateLabel"]
        let tripEndDateValueText = app.staticTexts["TripEndDateValueText"]
        let fareLabel = app.staticTexts["FareLabel"]
        let fareValue = app.staticTexts["FareValue"]
        let confirmButton = app.buttons["ConfirmButton"]
        
        XCTAssertTrue(tripSectionLabel.exists)
        XCTAssertTrue(tripStartDateLabel.exists)
        XCTAssertTrue(tripStartDateValueText.exists)
        XCTAssertTrue(tripEndDateLabel.exists)
        XCTAssertTrue(tripEndDateValueText.exists)
        XCTAssertTrue(fareLabel.exists)
        XCTAssertTrue(fareValue.exists)
        XCTAssertTrue(confirmButton.exists)
        
        confirmButton.tap()
        
        XCTAssertFalse(tripSearchResultList.exists)
    }
}
