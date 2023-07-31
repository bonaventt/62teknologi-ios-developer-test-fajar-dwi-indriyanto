//
//  CatFactView.swift
//  api-fajar2
//
//  Created by Sarah Tsabitah on 31/07/23.
//

import Foundation
import SwiftUI

struct Cat: Hashable, Codable {
    let fact: String
    let length: Int
}


// Connect to CatFact API
class CatViewModel : ObservableObject {
    @Published var cats : Cat = Cat(fact: "Cats can see in the dark", length: 77)
    
    func fetchData() {
        guard let url = URL(string: "https://catfact.ninja/fact") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Cat.self, from: data)
                DispatchQueue.main.async {
                    self.cats = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}

// CatFact page
struct CatFactView: View {
    @StateObject var catViewModel = CatViewModel()
    
    @Environment(\.presentationMode) var presentationModes

    var body: some View {
        ZStack{
            Color.teal
                .ignoresSafeArea()

            VStack(spacing: 100) {
                
                Text("Fun Fact About Cat: \n \(catViewModel.cats.fact)")
                    .navigationBarTitle("Cat Facts", displayMode: .inline)
                
                Button(action: {
                    catViewModel.fetchData()
                },
                       label: {
                    Text("Give Me Fact About Cat!")
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

struct CatFactView_Previews: PreviewProvider {
    static var previews: some View {
        CatFactView()
    }
}

