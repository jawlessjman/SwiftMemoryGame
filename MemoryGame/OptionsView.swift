//
//  OptionsView.swift
//  MemoryGame
//
//  Created by Jared Johnston on 2024-12-09.
//

import SwiftUI

struct OptionsView: View {
    @State var sound : Bool = true;
    @StateObject var vm = HighscoredViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Text("Options").font(.largeTitle)
            Spacer()
            Toggle(isOn:$sound){
                Text("option1")
            }
            Spacer()
            Button("Reset Highscores"){
                vm.deleteAll()
            }.font(.title2)
            Button("Back"){
                dismiss()
            }.font(.title2)
        }.padding()
    }
}

#Preview {
    OptionsView()
}
