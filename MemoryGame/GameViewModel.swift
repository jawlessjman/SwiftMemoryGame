//
//  GameViewModel.swift
//  MemoryGame
//
//  Created by Jared Johnston on 2024-12-09.
//

import Foundation

class GameViewModel : ObservableObject{
    @Published var gameObjects : [[Card]] = []
    @Published var selected : [Card] = []
    @Published var canFlip : Bool = true
    
    func addCardToQueue(n : Card) -> Bool{
        selected.append(n)
        
        if (selected.count == 2){
            canFlip = false
            if (selected[0].type == selected[1].type){
                for x in gameObjects{
                    for y in x{
                        if (y.id == selected[0].id || y.id == selected[1].id){
                            y.matched = true
                        }
                    }
                }
                selected = []
                canFlip = true
                return true
            }
        }
        return false
    }
    
    func removeCardFromQueue(n : Card){
        selected.removeAll { $0.id == n.id }
        canFlip = true
    }
    
    func getCards(num : Int){
        gameObjects = []
        
        let cols : Int = num / 5
        let rows : Int = num / cols
        
        var joel = 1
        var cards : [Card] = []
        for _ in 0 ..< num{
            cards.append(Card(num: joel))
            if (cards.count % 2 == 0){
                joel+=1
            }
        }
        
        for _ in 0 ..< Int.random(in: 1...10){
            cards.shuffle()
        }
        
        for x in 0 ..< cols{
            gameObjects.append([])
            for y in 0 ..< rows{
                gameObjects[x].append(cards[y + (x * rows)])
            }
        }
        
    }
    
}

class Card : Identifiable, ObservableObject{
    var id = UUID()
    var type : Int
    @Published var matched : Bool = false
    init(num : Int){
        type = num
    }
}
