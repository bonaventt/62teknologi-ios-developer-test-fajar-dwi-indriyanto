//
//  GuessGenderView.swift
//  api-fajar2
//
//  Created by Sarah Tsabitah on 31/07/23.
//

import Foundation
import SwiftUI

struct Persons: Hashable, Codable {
    let count: Int
    let name: String
    let gender: String?
    let probability: Double?
}

// Connect to Guess Gender API
class GenderViewModel : ObservableObject {
    @Published var persons : Persons = Persons(count: 0, name: "", gender: "", probability: nil)
    
    @Published var name = ""
    
    func fetchData() {
        guard let url = URL(string: "https://api.genderize.io/?name=\(name)") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Persons.self, from: data)
                DispatchQueue.main.async {
                    self.persons = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}

// Guess Gender Page
struct GuessGenderView: View {
    @StateObject var genderViewModel = GenderViewModel()

    @Environment(\.presentationMode) var presentationModes
    
    var body: some View {
        ZStack{
            Color.teal
                .ignoresSafeArea()
            VStack(spacing: 75) {
                Text("Your Gender Is")
                    .bold()
                    .padding()
                    .navigationBarTitle("Guess Gender", displayMode: .inline)
                
                VStack(spacing: 35) {
                    if let gender = genderViewModel.persons.gender {
                        Text("\(gender)")
                            .font(.system(size: 50))
                            .bold()
                            .padding()
                    } else {
                        Text("Unknown Name")
                            .font(.system(size: 30))
                            .bold()
                            .padding()
                    }
                    
                    if let prob = genderViewModel.persons.probability {
                        Text("Probability : \(ceil(prob))")
                            .font(.system(size: 30))
                            .bold()
                            .padding()
                    } else {
                        Text("Probability : ")
                            .font(.system(size: 30))
                            .bold()
                            .padding()
                    }
                    
                }
                
                
                TextField("Please Insert Your Name", text: $genderViewModel.name)
                    .padding()
                    .background(Color.white)
                    .frame(width: 300, height: 50)
                    .cornerRadius(10)
                
                Button(action: {
                    genderViewModel.fetchData()
                },
                       label: {
                    Text("What Is My Gender ?")
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

struct GuessGenderView_Previews: PreviewProvider {
    static var previews: some View {
        GuessGenderView()
    }
}
