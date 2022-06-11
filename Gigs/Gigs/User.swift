//
//  User.swift
//  AnimalSpotter
//
//  Created by Waseem Idelbi on 6/7/22.
//  Copyright © 2022 BloomTech. All rights reserved.
//

import Foundation

struct User: Codable {
    let username: String
    let password: String
}

enum LoginType {
    case logIn
    case signUp
}
