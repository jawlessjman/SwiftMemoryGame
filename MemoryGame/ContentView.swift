//
//  ContentView.swift
//  MemoryGame
//
//  Created by Jared Johnston on 2024-12-09.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack(alignment: .center, spacing: 20){
                Spacer()
                Text("Memory Game").font(.largeTitle)
                
                Spacer()
                
                NavigationLink(destination: DifficultyScreen()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)) {
                        Text("Play").font(.title)
                        }
                
                NavigationLink(destination: HighscoresView()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)) {
                        Text("Highscores").font(.title)
                        }
                
                NavigationLink(destination: OptionsView()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)) {
                        Text("Options").font(.title)
                        }
                
                Spacer()
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
