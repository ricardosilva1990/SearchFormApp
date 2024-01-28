import Foundation

struct TripResponseViewModel {
    // start date
    // arrival date
    // flight number
    // regular fare
    // total price
    // currency
    
    let startDate: String
    let endDate: String
    let flightNumber: String
    let regularFare: [String]
    let currency: String
    
//    private let model: TripModel
//
//    init(model: TripModel) {
//        self.model = model
//    }
    
    static func convert(trips: [TripResponseModel]) -> [TripResponseViewModel] {
        var result = [TripResponseViewModel]()
        
        trips.forEach { tripResultModel in
            tripResultModel.trips.forEach { tripModel in
                tripModel.dates.forEach { dateModel in
                    dateModel.flights.forEach { flightModel in
                        let item = TripResponseViewModel(
                            startDate: flightModel.timeUTC.first!,
                            endDate: flightModel.timeUTC.last!,
                            flightNumber: flightModel.flightNumber,
                            regularFare: flightModel.regularFare.fares.map({ "\($0.amount * Double($0.count))" }),
                            currency: tripResultModel.currency
                        )
                        result.append(item)
                    }
                }
            }
        }
        
        return result
    }
}
