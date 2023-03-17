//
//  Game.swift
//  Sport-Crowd
//
//  Created by Ivan Pryhara on 17.03.23.
//

import Foundation

class Game: Identifiable {
    var id = UUID()
    var team0: Team
    var team1: Team
    
    var team0Score: Int
    var team1Score: Int
    
    var gamePart: String
    var gameTime: Int
    
    var previewImageName: String
    
    init(team0: Team,
         team1: Team,
         team0Score: Int,
         team1Score: Int,
         gamePart: String,
         gameTime: Int,
         previewImageName: String) {
        
        self.team0 = team0
        self.team1 = team1
        self.team0Score = team0Score
        self.team1Score = team1Score
        self.gamePart = gamePart
        self.gameTime = gameTime
        self.previewImageName = previewImageName
        
    }
}

extension Game: Hashable {
    static func == (lhs: Game, rhs: Game) -> Bool {
        lhs.id == rhs.id && lhs.team0 == rhs.team1
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine("\(id)\(team0.id)\(team1.id)")
    }
}
