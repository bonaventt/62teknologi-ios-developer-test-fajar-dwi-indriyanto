//
//  GuessAgeView.swift
//  api-fajar2
//
//  Created by Sarah Tsabitah on 31/07/23.
//

import Foundation
import SwiftUI

struct Person: Hashable, Codable {
    let count: Int
    let name: String
    let age: Int
}

// Connect to Guess Age API
class AgeViewModel : ObservableObject {
    @Published var person : Person = Person(count: 21, name: "Meelad", age: 33)
    
    @Published var name = ""
    
    func fetchData() {
        guard let url = URL(string: "https://api.agify.io/?name=\(name)") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Person.self, from: data)
                DispatchQueue.main.async {
                    self.person = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}

// Guess Age Page
struct GuessAgeView: View {
    @StateObject var ageViewModel = AgeViewModel()

    @Environment(\.presentationMode) var presentationModes
    
    var body: some View {
        ZStack{
            Color.teal
                .ignoresSafeArea()
            VStack(spacing: 100) {
                Text("Your name is \(ageViewModel.person.name), And i guess you're \(ageViewModel.person.age) years old, With the total count of person is \(ageViewModel.person.count)")
                    .padding()
                    .navigationTitle("Guess Age")
                    .navigationBarTitleDisplayMode(.inline)
                
                TextField("Please Insert Your Name", text: $ageViewModel.name)
                    .padding()
                    .background(Color.white)
                    .frame(width: 300, height: 50)
                    .cornerRadius(10)
                
                Button(action: {
                    ageViewModel.fetchData()
                },
                       label: {
                    Text("How Old Am I ?")
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

struct GuessAgeView_Previews: PreviewProvider {
    static var previews: some View {
        GuessAgeView()
    }
}

