//
//  UserList.swift
//  fake-people
//
//  Created by Ismail Tever on 21.03.2023.
//

import Foundation

struct ListUser: Codable {
    let page : Int
    let per_page : String
    let total : String
    let total_pages : String
    let data : User
    let support : Support
}
