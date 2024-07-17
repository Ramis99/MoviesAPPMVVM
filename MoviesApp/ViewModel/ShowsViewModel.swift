//
//  ShowsViewModel.swift
//  MoviesApp
//
//  Created by Ramiro Gutierrez on 13/07/24.
//

import Foundation

class ShowsViewModel {
    
    var showData: [ShowsModel] = []
    var showSelected: ShowsModel?
    let apiService = APIService()
    let coreDataManager = CoreDataManager()
    let alert = CustomAlertsView()
    var isFavoriteTab = false
    var favoriteShow: [ShowsModel] = []
    var connectivityChecker: ConnectivityChecker = ReachabilityChecker()


    func fetchAllShows(completion: @escaping () -> Void) {
        apiService.fetchAllShows { result in
            
            switch result {
            case .success(let shows):
                self.showData = shows
                completion()
            case .failure(let error):
                print("Error al obtener shows", error.localizedDescription)
                completion()
            }
            
        }
    }
    
    func filterFavoriteShows() {
        favoriteShow = showData.filter { $0.isFavorite == true }
        print("peliculas filtradas", favoriteShow)
    }
}
