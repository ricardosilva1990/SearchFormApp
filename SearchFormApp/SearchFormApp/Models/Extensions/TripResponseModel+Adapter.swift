import Foundation

extension TripResponseModel {
    var tripResponseViewModelArray: [TripResponseViewModel] {
        do {
            let abc = try self.trips.flatMap {
                try $0.dates.flatMap {
                    try $0.flights.map {
                        guard $0.timeUTC.count == 2, let startDate = $0.timeUTC.first, let endDate = $0.timeUTC.last
                        else { throw ConversionError.dateIssue }
                        
                        return try TripResponseViewModel(
                            startDate: startDate,
                            endDate: endDate,
                            flightNumber: $0.flightNumber,
                            regularFare: $0.regularFare?.fares.map(TripFareViewModel.init),
                            currency: currency
                        )
                    }
                }
            }
          
            return abc
        } catch {
            return []
        }
    }
}

extension TripFareViewModel {
    init(_ fareModel: FareModel) throws {
        guard let type = FareType(rawValue: fareModel.type) else { throw ConversionError.fareIssue }
        
        self.init(type: type, amount: fareModel.amount, count: fareModel.count, discountAmount: fareModel.discountAmount)
    }
}
