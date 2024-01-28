import Foundation

struct TripFareViewModel: Identifiable {
    enum FareType: String, CustomStringConvertible {
        case adult = "ADT"
        case teen = "TEEN"
        case child = "CHD"
        
        var description: String {
            switch self {
            case .adult: return "Adults"
            case .teen: return "Teens"
            case .child: return "Children"
            }
        }
    }
    
    var id = UUID()
    
    let type: FareType
    let amount: Double
    let count: Int
    let discountAmount: Double
    
    var finalAmount: String {
        String(format: "%.2f", amount - discountAmount)
    }
}

extension TripFareViewModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: TripFareViewModel, rhs: TripFareViewModel) -> Bool {
        lhs.id == rhs.id
    }
}
