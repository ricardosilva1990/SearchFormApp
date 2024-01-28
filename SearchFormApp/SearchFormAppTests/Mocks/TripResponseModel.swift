import Foundation
@testable import SearchFormApp

struct TripResponseModelMocks {
    static let validResponse = TripResponseModel(currency: "USD", trips: [TripModelMocks.validResponse])
    static let noDates = TripResponseModel(currency: "USD", trips: [TripModelMocks.noDates])
    static let tooLittleDates = TripResponseModel(currency: "USD", trips: [TripModelMocks.tooLittleDates])
    static let tooManyDates = TripResponseModel(currency: "USD", trips: [TripModelMocks.tooManyDates])
}

struct TripModelMocks {
    static let validResponse = TripModel(dates: [TripDateModelMocks.validResponse])
    static let noDates = TripModel(dates: [TripDateModelMocks.noDates])
    static let tooLittleDates = TripModel(dates: [TripDateModelMocks.tooLittleDates])
    static let tooManyDates = TripModel(dates: [TripDateModelMocks.tooManyDates])
}

struct TripDateModelMocks {
    static let validResponse = TripDateModel(flights: [TripDateFlightModelMocks.validResponse])
    static let noDates = TripDateModel(flights: [TripDateFlightModelMocks.noDates])
    static let tooLittleDates = TripDateModel(flights: [TripDateFlightModelMocks.tooLittleDates])
    static let tooManyDates = TripDateModel(flights: [TripDateFlightModelMocks.tooManyDates])
}

struct TripDateFlightModelMocks {
    static let validResponse = TripDateFlightModel(
        regularFare: TripDateFlightRegularFareModelMocks.mock, flightNumber: "FN #1", timeUTC: [Date(), Date()]
    )
    static let noDates = TripDateFlightModel(
        regularFare: TripDateFlightRegularFareModelMocks.mock, flightNumber: "FN #1", timeUTC: []
    )
    static let tooLittleDates = TripDateFlightModel(
        regularFare: TripDateFlightRegularFareModelMocks.mock, flightNumber: "FN #1", timeUTC: [Date()]
    )
    static let tooManyDates = TripDateFlightModel(
        regularFare: TripDateFlightRegularFareModelMocks.mock, flightNumber: "FN #1", timeUTC: [Date(), Date(), Date()]
    )
}

struct TripDateFlightRegularFareModelMocks {
    static let mock = TripDateFlightRegularFareModel(fares: [FareModelMocks.mock])
}

struct FareModelMocks {
    static let mock = FareModel(type: "ADT", amount: 10.0, count: 1, discountAmount: 1.0)
}
