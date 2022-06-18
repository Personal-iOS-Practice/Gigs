//
//  PlaceholderGig.swift
//  Gigs
//
//  Created by Waseem Idelbi on 6/17/22.

//MARK: - This model only exists to help decode the date property into a string, in order to remove the milliseconds
//MARK:   This way it'll be convertable to Date using iso8601 format -

import Foundation

struct PlaceholderGig: Codable, Equatable {
    
//MARK: - Properties
    var title: String
    var description: String
    var dueDate: String
    
//MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case description = "hair_color"
        case dueDate = "created"
    }
    
}
