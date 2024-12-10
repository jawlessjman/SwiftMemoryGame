//
//  HighscoredViewModel.swift
//  MemoryGame
//
//  Created by Jared Johnston on 2024-12-09.
//

import Foundation
import CoreData

class HighscoredViewModel : ObservableObject{
    @Published var highscores : [Score] = []
    
    let viewContext : NSManagedObjectContext
    
    init(){
        viewContext = PersistenceController.shared.container.viewContext
        
        fetchScores()
    }
    
    func fetchScores(){
        let request = NSFetchRequest<Score>(entityName: "Score")
        
        do{
            try highscores = viewContext.fetch(request)
            
        }
        catch{
            print("Error: \(error)")
        }
    }
    
    func saveData(){
        do{
            try viewContext.save()
        }catch{
            print("Error: \(error)")
        }

        fetchScores()
        sortData()
    }
    
    func sortData(){
        highscores.sort { $0.score > $1.score }
    }
    
    func addData(scoreI: Int16, chance : Int16, time: String){
        let score = Score(context: viewContext)
        
        score.chances = chance
        score.time = time
        score.score = scoreI;
        score.id = UUID()
        
        saveData()
    }
    
    func removeOrder(offset : IndexSet){
        offset.map {highscores[$0]}.forEach(viewContext.delete)
        
        saveData()
    }
    
    func deleteAll(){
        highscores.forEach{score in
            viewContext.delete(score)
        }
        highscores = []
        
        saveData()
    }
}
