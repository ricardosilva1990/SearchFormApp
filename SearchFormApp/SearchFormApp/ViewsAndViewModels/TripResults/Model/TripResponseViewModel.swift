import Foundation

struct TripResponseViewModel: Identifiable {
    let startDate: Date
    let endDate: Date
    let flightNumber: String
    let regularFare: [TripFareViewModel]?
    let currency: String
    
    var id = UUID()
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }
    
    var startDateLabel: String {
        dateFormatter.string(from: startDate)
    }
    
    var endDateLabel: String {
        dateFormatter.string(from: endDate)
    }
}

extension TripResponseViewModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: TripResponseViewModel, rhs: TripResponseViewModel) -> Bool {
        lhs.id == rhs.id
    }
}
