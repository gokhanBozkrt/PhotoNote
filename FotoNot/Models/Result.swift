//
//  Result.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 31.08.2022.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var descriptionTerms: String {
        terms?["description"]?.first ?? "No furher information"
    }
    
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}
