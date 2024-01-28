import Foundation

struct TripSearchModel: Codable {
    let origin: String
    let destination: String
    let departureDate: Date
    let adultNumber: Int
    let teenNumber: Int
    let childNumber: Int
    let termsOfUse: String = "AGREED"
    
    enum CodingKeys: String, CodingKey {
        case origin
        case destination
        case departureDate = "dateout"
        case adultNumber = "adt"
        case teenNumber = "teen"
        case childNumber = "chd"
        case termsOfUse = "ToUS"
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    var toDictionary: [String: Any] {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        
        guard let data = try? encoder.encode(self),
                let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        else { return [:] }
        return dictionary
    }
}
