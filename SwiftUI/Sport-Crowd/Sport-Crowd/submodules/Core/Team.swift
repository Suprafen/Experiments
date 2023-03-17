//
//  GameTeam.swift
//  Sport-Crowd
//
//  Created by Ivan Pryhara on 17.03.23.
//

import Foundation

class Team: Identifiable {
    var id = UUID()
    
    var fullName: String
    var acronym: String
    var name: String
    
    var losses: Int
    var wins: Int
    
    init(fullName: String, acronym: String, name: String, losses: Int, wins: Int) {
        self.fullName = fullName
        self.acronym = acronym
        self.name = name
        self.losses = losses
        self.wins = wins
    }
}

extension Team: Hashable {
    static func == (lhs: Team, rhs: Team) -> Bool {
        lhs.fullName == rhs.fullName && lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine("\(fullName)\(id)")
    }
}
