//
//  GameView.swift
//  MemoryGame
//
//  Created by Jared Johnston on 2024-12-09.
//

import SwiftUI

struct GameView: View {
    @State var tiles : Int
    @StateObject var vm = GameViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .center, spacing: 30){
            List{
                ForEach(vm.gameObjects.indices, id:\.self){ list in
                    HStack(alignment: .center){
                        ForEach(vm.gameObjects[list]){ item in
                            FlippingCard(vm: vm, content: item)
                        }
                    }
                }
            }.onAppear(perform: fetchCards)
            
            Button("Exit"){
                dismiss()
            }
        }
    }
    
    func fetchCards(){
        vm.getCards(num: tiles)
    }
}

struct FlippingCard: View {
    @State private var isFlipped = false
    @State private var isAnimating = false
    @State private var isDead = false
    @StateObject var vm : GameViewModel
    let content : Card // The content to show when the card is flipped
    
    var body: some View {
        if (!isDead){
            ZStack {
                // Front Side of the Card
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.blue)
                    .frame(width: 60, height: 100)
                    .opacity(isFlipped ? 0 : 1) // Hide when flipped
                    .rotation3DEffect(.degrees(isAnimating ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                
                // Back Side of the Card
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.red)
                    .frame(width: 60, height: 100)
                    .overlay(Text("\(content.type)").foregroundColor(.white).font(.headline))
                    .opacity(isFlipped ? 1 : 0) // Show when flipped
                    .rotation3DEffect(.degrees(isAnimating ? 0 : -180), axis: (x: 0, y: 1, z: 0))
            }
            .onTapGesture {
                flipCard()
            }
            .animation(.easeInOut(duration: 0.8), value: isAnimating).onAppear(perform: setDeadParameter)
        }
        else {
                    // Display the "matched" state with no opacity (card is invisible but still takes up space)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.clear)
                        .frame(width: 60, height: 100)
                }
    }
    
    func setDeadParameter(){
        isDead = content.matched
    }
    
    private func flipCard() {
        guard !isAnimating else { return }
        if (!vm.canFlip || content.matched){
            return
        }
        
        isAnimating = true
        isFlipped.toggle()
        
        if (isFlipped){
            isDead = vm.addCardToQueue(n: content)
        }
        
        // Optionally, flip back after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isFlipped.toggle()
            isAnimating = false
            
            if (!isFlipped){
                vm.removeCardFromQueue(n: content)
            }
        }
    }
}

#Preview {
    GameView(tiles: 5)
}
