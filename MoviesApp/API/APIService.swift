//
//  APIService.swift
//  MoviesApp
//
//  Created by Ramiro Gutierrez on 13/07/24.
//

import Foundation

class APIService {
    
    
    func fetchAllShows(completion: @escaping (Result<[ShowsModel], Error>) -> Void) {
        let urlString = URLs.getAllShows
        guard let url = URL(string: urlString) else { return }
        

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {return}
            do {
                let shows = try JSONDecoder().decode([ShowsModel].self, from: data)
                completion(.success(shows))
            } catch(let error) {
                print("Ocurrio un error", error.localizedDescription)
            }
        }.resume()
    }
}
