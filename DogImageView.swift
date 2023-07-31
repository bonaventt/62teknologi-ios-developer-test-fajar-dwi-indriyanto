//
//  DogImageView.swift
//  api-fajar2
//
//  Created by Sarah Tsabitah on 31/07/23.
//

import Foundation
import SwiftUI

struct Dog: Hashable, Codable {
    let message: String
    let status: String
}

// Connect to Dog Image API
class DogViewModel : ObservableObject {
    @Published var dogs : Dog = Dog(message: "https://images.dog.ceo/breeds/setter-english/n02100735_3998.jpg", status: "success")
    
    func fetchData() {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Dog.self, from: data)
                DispatchQueue.main.async {
                    self.dogs = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}

// Random Dog Image Page
struct DogImageView: View {
    @StateObject var dogViewModel = DogViewModel()
    
    @Environment(\.presentationMode) var presentationModes

    var body: some View {
        ZStack{
            Color.teal
                .ignoresSafeArea()
            VStack(spacing: 100) {
                AsyncImage(url: URL(string: dogViewModel.dogs.message)) {image in
                    
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.blue)
                }
                .frame(width: 500, height: 250)
                
                // AsyncImage(url: URL(string: dogViewModel.dogs.message))
                .navigationBarTitle("Random Dog Image", displayMode: .inline)
                
                Button(action: {
                    dogViewModel.fetchData()
                },
                       label: {
                    Text("Choose Your Dog!")
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

struct DogImageView_Previews: PreviewProvider {
    static var previews: some View {
        DogImageView()
    }
}
