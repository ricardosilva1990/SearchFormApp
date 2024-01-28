import SwiftUI

struct StationListView<ViewModel: StationListViewModelProtocol, Router: RoutingProtocol>: View where Router.Route == StationListViewRoute {
    @StateObject var viewModel: ViewModel
    @ObservedObject var router: Router
    
    @Binding var selectedStation: StationViewModel?
    
    @State private var searchText: String = ""
    
    private var searchResults: [StationViewModel] {
        searchText.isEmpty ? viewModel.stationArray : viewModel.stationArray.filter { $0.code.hasPrefix(searchText) || $0.name.hasPrefix(searchText)
        }
    }
    
    var body: some View {
        Group {
            if viewModel.stationArray.isEmpty {
                Text(viewModel.noResultsLabel)
                    .foregroundColor(.gray)
            } else {
                List(searchResults, id: \.self, selection: $selectedStation) { station in
                    Text(station.name)
                        .accessibilityIdentifier("StationName")
                }
                .onChange(of: selectedStation) { _ in
                    searchText = " "    // this is required due to this: https://stackoverflow.com/questions/75209612/navigation-bug-when-dismissing-view-while-focussing-on-empty-searchable-modif
                    router.pop()
                }
                .accessibilityIdentifier("StationList")
            }
        }
        .navigationTitle(viewModel.titleLabel(for: selectedStation))
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onAppear {
            viewModel.fetchStationList()
        }
    }
}

struct StationListView_Previews: PreviewProvider {
    private struct BindingTestHolder: View {
        @State var selectedStation: StationViewModel?
        @State var path = NavigationPath()
        
        var body: some View {
            let viewModel = StationListViewPreviewModel()
            StationListView(viewModel: viewModel, router: StationListViewRouting(path: $path), selectedStation: $selectedStation)
        }
    }
    
    static var previews: some View {
        BindingTestHolder()
    }
}
