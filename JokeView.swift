//
//  JokeView.swift
//  api-fajar2
//
//  Created by Sarah Tsabitah on 31/07/23.
//

import SwiftUI

struct Jokes: Hashable, Codable {
    let type: String
    let setup: String
    let punchline: String
    let id: Int
}

// Connect to Joke API
class JokeViewModel : ObservableObject {
    @Published var jokes: Jokes = Jokes(type: "general", setup: "Why was Cinderalla thrown out of the football team?", punchline: "Because she ran away from the ball.", id: 380)
    
    func fetchData() {
        guard let url = URL(string: "https://official-joke-api.appspot.com/random_joke") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Jokes.self, from: data)
                DispatchQueue.main.async {
                    self.jokes = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}

// Random Jokes Page
struct JokeView: View {
    @StateObject var jokeViewModel = JokeViewModel()
    
    @Environment(\.presentationMode) var presentationModes

    var body: some View {
        ZStack{
            Color.teal
                .ignoresSafeArea()
            VStack(spacing: 100) {
                Text("\(jokeViewModel.jokes.setup) \n \(jokeViewModel.jokes.punchline)")
                    .navigationBarTitle("Random Jokes", displayMode: .inline)
                    
                Button(action: {
                    jokeViewModel.fetchData()
                },
                       label: {
                    Text("Give Me Joke!")
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(Color.orange)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                })

                Button(action: {
                    presentationModes.wrappedValue.dismiss()
                }, label: {
                    Text("Back To Main Menu")
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(Color.clear)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                })
            }
        }
    }
}

struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView()
    }
}
