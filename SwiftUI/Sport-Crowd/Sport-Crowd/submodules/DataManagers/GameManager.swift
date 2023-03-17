//
//  GameManager.swift
//  Sport-Crowd
//
//  Created by Ivan Pryhara on 17.03.23.
//

import Foundation
import SwiftUI

class GameManager: ObservableObject {
    
    @Published var games: [Game] = Mocks.shared.getGames()
    
}
