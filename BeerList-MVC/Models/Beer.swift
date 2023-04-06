//
//  Beer.swift
//  BeerList-MVC
//
//  Created by Vladyslav Nhuien on 06.04.2023.
//

import Foundation

struct Beer: Codable, Equatable {
    var id: Int?
    var name: String?
    var description: String?
    var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case imageURL = "image_url"
    }
}
