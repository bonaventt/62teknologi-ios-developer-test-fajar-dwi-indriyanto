//
//  HomePageView.swift
//  api-fajar2
//
//  Created by Sarah Tsabitah on 31/07/23.
//

import Foundation
import SwiftUI

struct HomePageView : View {
    private var data:  [Int] = Array(1...6)
    private let colors: [Color] = [.orange]
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    
    
    var body : some View {
        NavigationStack{
            ZStack{
                Color.teal
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: adaptiveColumns, spacing: 25) {
                        
                        // to Random Jokes Page
                        NavigationLink(destination: JokeView(), label: {
                            ZStack{
                                Rectangle()
                                    .frame(width: 170, height: 170)
                                    .foregroundColor(Color.orange)
                                    .cornerRadius(30)
                                VStack{
                                    Text("Jokes")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                }
                            }
                        })
                        
                        // to Cat Fact Page
                        NavigationLink(destination: CatFactView(), label:{
                            ZStack{
                                Rectangle()
                                    .frame(width: 170, height: 170)
                                    .foregroundColor(Color.orange)
                                    .cornerRadius(30)
                                VStack{
                                    Text("Cat Fact")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                }
                            }
                        })
                        
                        // to Random Dog Image Page
                        NavigationLink(destination: DogImageView(), label: {
                            ZStack{
                                Rectangle()
                                    .frame(width: 170, height: 170)
                                    .foregroundColor(Color.orange)
                                    .cornerRadius(30)
                                VStack{
                                    Text("Random Dogs")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                    Text("Image")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                }
                            }
                        })
                        
                        // to Guess Age Page
                        NavigationLink(destination: GuessAgeView(), label: {
                            ZStack{
                                Rectangle()
                                    .frame(width: 170, height: 170)
                                    .foregroundColor(Color.orange)
                                    .cornerRadius(30)
                                VStack{
                                    Text("Guess Age")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                }
                            }
                        })
                        
                        // to Guess Gender Page
                        NavigationLink(destination: GuessGenderView(), label: {
                            ZStack{
                                Rectangle()
                                    .frame(width: 170, height: 170)
                                    .foregroundColor(Color.orange)
                                    .cornerRadius(30)
                                VStack{
                                    Text("Guess")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                    Text("Gender")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                }
                            }
                        })
                        
                        // to Ip Info Page
                        NavigationLink(destination: IpInfoView(), label: {
                            ZStack{
                                Rectangle()
                                    .frame(width: 170, height: 170)
                                    .foregroundColor(Color.orange)
                                    .cornerRadius(30)
                                VStack{
                                    Text("Ip Info")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                    Text("Location")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                }
                            }
                        })
                    }
                }
                .padding()
                .navigationTitle("Main Menu")
            }
        }
    }
}


struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

