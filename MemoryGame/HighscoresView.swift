//
//  HighscoresView.swift
//  MemoryGame
//
//  Created by Jared Johnston on 2024-12-09.
//

import SwiftUI

struct HighscoresView: View {
    @StateObject var vm = HighscoredViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Text("Highscores").font(.largeTitle)
        List{
            ForEach(vm.highscores){score in
                VStack{
                    Text("\(score.score)")
                    Text("\(score.chances)")
                    Text(score.time ?? "None")
                }
            }
        }
        Button("Back"){
            dismiss()
        }.font(.title2)
        
    }
}

#Preview {
    HighscoresView()
}
