//
//  ContentView.swift
//  TicTacToe
//
//  Created by emre argana on 16.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isHumansTurn = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(0..<9, id: \.self){ index in
                        ZStack {
                            Circle()
                                .foregroundColor(.red)
                                .opacity(0.5)
                                .frame(width: geometry.size.width / 3 - 15,
                                       height: geometry.size.width / 3 - 15)
                            
                            Image(systemName: moves[index]?.indicator ?? "")
                                .resizable()
                                .frame(width: geometry.size.width/10,
                                       height: geometry.size.width/10)
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            if isSquareOccupied(in: moves, forIndex: index) { // moves[index]?.indicator == nil {
                                moves[index] = Move(player: isHumansTurn ? .human: .computer, boardIndex: index)
                                isHumansTurn.toggle() // isHumansTurn = !isHumansTurn
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
    
    func isSquareOccupied(in moves:[Move?], forIndex index: Int) -> Bool {
        moves.contains(where: {$0?.boardIndex == index})
    }
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
}

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex : Int
    
    var indicator: String {
        player == .human ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
