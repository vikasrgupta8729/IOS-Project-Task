//
//  Model.swift
//  Vikas_task2
//
//  Created by BATWOMAN on 21/04/23.
//

import Foundation


struct MoviesData: Decodable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    
    let title: String?
    let posterImage: String?
    let overview: String?
    var checkbox: Bool
    
    private enum CodingKeys: String, CodingKey {
        case title, overview
        case posterImage = "poster_path"
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        posterImage = try values.decode(String.self, forKey: .posterImage)
        overview = try values.decode(String.self, forKey: .overview)
        checkbox = false // Initialize checkbox with a default value
    }
}
