//
//  SplashScreenView.swift
//  api-fajar2
//
//  Created by Sarah Tsabitah on 31/07/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View{
        if isActive {
            HomePageView()
        } else {
            ZStack{
                Color.teal
                    .ignoresSafeArea()
                    
                ZStack{
                    Image("logo")
                    .font(.system(size:50))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration:1.2)){
                    self.size = 0.9
                    self.opacity = 1.0
                    }
                }
            }

            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    withAnimation{
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

