import Foundation

struct TripResponseModel: Codable {
    let currency: String
    let trips: [TripModel]
}

struct TripModel: Codable {
    let dates: [TripDateModel]
}

struct TripDateModel: Codable {
    let flights: [TripDateFlightModel]
}

struct TripDateFlightModel: Codable {
    let regularFare: TripDateFlightRegularFareModel?
    let flightNumber: String
    let timeUTC: [Date]
}

struct TripDateFlightRegularFareModel: Codable {
    let fares: [FareModel]
}

struct FareModel: Codable {
    let type: String
    let amount: Double
    let count: Int
    let discountAmount: Double
}
