//
//  DifficultyScreen.swift
//  MemoryGame
//
//  Created by Jared Johnston on 2024-12-09.
//

import SwiftUI

struct DifficultyScreen: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            VStack(alignment: .center, spacing: 30){
                Text("Select Difficulty").font(.largeTitle)
                
                Spacer()
                
                NavigationLink(destination: GameView(tiles: 5).navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)) {
                        Text("Easy").font(.title)
                        }
                
                NavigationLink(destination: GameView(tiles:20)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)) {
                        Text("Medium").font(.title)
                        }
                
                NavigationLink(destination: GameView(tiles: 30)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)) {
                        Text("Hard").font(.title)
                        }
                
                Spacer()
                
                Button("Back"){
                    dismiss()
                }.font(.title2)
            }
        }
    }
}

#Preview {
    DifficultyScreen()
}
