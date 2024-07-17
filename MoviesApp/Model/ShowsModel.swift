//
//  ShowsModel.swift
//  MoviesApp
//
//  Created by Ramiro Gutierrez on 13/07/24.
//

import Foundation

struct ShowsModel: Codable {
    let idShow: Int!
    let name: String?
    let imageUrl: ImageShows?
    let summary: String?
    let language: String?
    let genres: [String]?
    let rating: Rating?
    let external: External?
    let premiered: String?
    var isFavorite: Bool?
    var url: String?
    
    
    enum CodingKeys: String, CodingKey {
        case idShow = "id"
        case name = "name"
        case imageUrl = "image"
        case summary
        case language
        case genres
        case rating
        case external = "externals"
        case premiered
        case isFavorite
        case url
        
    }
    
    struct ImageShows: Codable {
        let imageMedium: String?
        
        enum CodingKeys: String, CodingKey {
            case imageMedium = "medium"
        }
    }
    
    struct External: Codable {
        let imdb: String?
        
        enum CodingKeys: String, CodingKey {
            case imdb
        }
    }
    
    struct Rating: Codable {
        let average: Double?
        
        enum CodingKeys: String, CodingKey {
            case average
        }
    }
}
