//
//  Gig.swift
//  Gigs
//
//  Created by Waseem Idelbi on 6/14/22.
//

import Foundation

struct Gig: Codable, Equatable {
    
//MARK: - Properties
    var title: String
    var description: String
    var dueDate: Date
    
//MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case description = "hair_color"
        case dueDate = "created"
    }
    
}
