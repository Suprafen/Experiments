//
//  Mocks.swift
//  Sport-Crowd
//
//  Created by Ivan Pryhara on 17.03.23.
//

import Foundation

class Mocks {
    
    static let shared = Mocks()
    
    private init () {}
    
    
    func getGames() -> [Game] {
        [
            Game(team0: nuggetsTeam, team1: newOrleansPelicans, team0Score: 90, team1Score: 111, gamePart: "Q1", gameTime: 260, previewImageName: "nuggets-mock-match"),
            Game(team0: nyKnicks, team1: laLakers, team0Score: 60, team1Score: 41, gamePart: "Q2", gameTime: 400, previewImageName: "lakers-mock-match"),
            Game(team0: bostonCeltics, team1: phoenixSuns, team0Score: 10, team1Score: 14, gamePart: "Q1", gameTime: 120, previewImageName: "celtics-mock-match")
        ]
    }
    
    let nuggetsTeam = Team(fullName: "Denver Nuggets", acronym: "DEN", name: "Nuggets", losses: 23, wins: 47)
    let bostonCeltics = Team(fullName: "Boston Celtics", acronym: "BOS", name: "Celtics", losses: 22, wins: 48)
    let laLakers = Team(fullName: "Los Angeles Lakers", acronym: "LAL", name: "Lakers", losses: 34, wins: 36)
    let newOrleansPelicans = Team(fullName: "New Orleans Pelicans", acronym: "NOP", name: "Pelicans", losses: 36, wins: 33)
    let nyKnicks = Team(fullName: "New York Knicks", acronym: "NYK", name: "Knicks", losses: 29, wins: 39)
    let phoenixSuns = Team(fullName: "Phoenix Suns", acronym: "PHO", name: "Suns", losses: 32, wins: 38)
    
}
