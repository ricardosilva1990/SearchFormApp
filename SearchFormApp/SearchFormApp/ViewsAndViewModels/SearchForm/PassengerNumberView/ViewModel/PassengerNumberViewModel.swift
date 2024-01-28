struct AdultNumberViewModel: PassengerNumberViewModelProtocol {
    var label: String { "Adults" }
    var minimumNumber: Int { 1 }
    var maximumNumber: Int { 6 }
}

struct TeenNumberViewModel: PassengerNumberViewModelProtocol {
    var label: String { "Teens" }
    var minimumNumber: Int { 0 }
    var maximumNumber: Int { 6 }
}

struct ChildNumberViewModel: PassengerNumberViewModelProtocol {
    var label: String { "Childs"}
    var minimumNumber: Int { 0 }
    var maximumNumber: Int { 6 }
}
