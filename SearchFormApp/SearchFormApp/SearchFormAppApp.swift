import SwiftUI

@main
struct SearchFormAppApp: App {
    var body: some Scene {
        WindowGroup {
            let router = SearchFormViewRouter()
            let searchFormViewModel = SearchFormViewModel()
            SearchFormView(router: router, searchFormViewModel: searchFormViewModel)
        }
    }
}
