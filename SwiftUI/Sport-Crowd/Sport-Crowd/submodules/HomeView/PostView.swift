//
//  PostView.swift
//  Sport-Crowd
//
//  Created by Ivan Pryhara on 17.03.23.
//

import SwiftUI

struct PostView: View {
    private var game: Game
    
    init(game: Game) {
        self.game = game
    }
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 0.5)
                    .fill(.secondary)
                
                VStack {
                    Image(game.previewImageName)
                        .resizable()
                        .cornerRadius(10, corners: [.topLeft, .topRight])
                        .overlay(alignment: .bottom) {
                            Text("\(game.team0.name.uppercased()) @ \(game.team1.name.uppercased())")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .offset(y: -20)
                        }
                    
                    VStack(spacing: 10) {
                        LastLiveMessageView(text: " text goes here.")
                        Divider()
                            .padding(.horizontal, 5)
                        ScoreView(game: game)
                        Divider()
                            .padding(.horizontal, 5)
                        BroadCastChannelView()
                    }
                    .padding(.horizontal, 5)
                }
            }
            .frame(height: proxy.size.height)
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

private struct LastLiveMessageView: View {
    private var text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.callout)
            .lineLimit(1)
            .padding(.horizontal, 5)
    }
}

private struct ScoreView: View {
    
    @State var game: Game
    
    var body: some View {
        HStack {
            teamView(game.team0)
            teamScore(game.team0Score)
            gameTime(game.gameTime, gamePart: game.gamePart)
            teamScore(game.team1Score)
            teamView(game.team1)
        }
    }
    
    @ViewBuilder
    private func teamView(_ gameTeam: Team) -> some View {
        VStack {
            Image(gameTeam.acronym)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            //TODO: Make sure image looks good.
            Text(gameTeam.name)
                .font(.caption2)
            Text("\(gameTeam.wins)-\(gameTeam.losses)")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder
    private func teamScore(_ teamScore: Int) -> some View {
        Text("\(teamScore)")
            .font(.largeTitle)
            .bold()
            .padding(.horizontal, 10)
    }
    
    private func gameTime(_ gameTime: Int, gamePart: String) -> some View {
        HStack(alignment: .center, spacing: 5) {
            Circle()
                .fill(.red)
                .frame(width: 5, height: 5, alignment: .center)
            //MARK: Part of the game
            Text(gamePart)
                .font(.caption)
                .bold()
            Text("\(gameTime / 60):32")
                .font(.caption)
        }
    }
}

private struct BroadCastChannelView: View {
    
    init() {}
    
    var body: some View {
        
        Button {
            print("Go to the web site of the channel.")
        } label: {
            HStack(spacing: 5) {
                Text("ESPN")
                    .italic()
                    .bold()
            }
            .foregroundColor(.black)
            
        }
        .padding(.bottom, 10)
    }
}
