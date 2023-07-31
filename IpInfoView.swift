//
//  IpInfoView.swift
//  api-fajar2
//
//  Created by Sarah Tsabitah on 31/07/23.
//

import Foundation
import SwiftUI

struct LocationInfo : Hashable, Codable {
    let ip: String
    let city: String
    let region: String
    let country: String
    let loc: String
    let org: String
    let postal: String
    let timezone: String
    let readme: String
}

// Connect to Ip Info API
class IpInfoViewModel : ObservableObject {
    @Published var location : LocationInfo = LocationInfo(ip: "", city: "", region: "", country: "", loc: "", org: "", postal: "", timezone: "", readme: "")
    
    @Published var ip = ""
    
    func fetchData() {
        guard let url = URL(string: "https://ipinfo.io/\(ip)/geo") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(LocationInfo.self, from: data)
                DispatchQueue.main.async {
                    self.location = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}

// Ip Info Page
struct IpInfoView: View {
    @StateObject var locationViewModel = IpInfoViewModel()
    
    @Environment(\.presentationMode) var presentationModes

    var body: some View {
        ZStack{
            Color.teal
                .ignoresSafeArea()
            VStack(spacing: 35) {
                VStack {
                    Text("City : \(locationViewModel.location.city)")
                        .frame(width: 250, alignment: .leading)
                    Text("Region : \(locationViewModel.location.region)")
                        .frame(width: 250, alignment: .leading)
                    Text("Country : \(locationViewModel.location.country)")
                        .frame(width: 250, alignment: .leading)
                    Text("Location : \(locationViewModel.location.loc)")
                        .frame(width: 250, alignment: .leading)
                }
                        
                    
                VStack {
                    TextField("Please Insert the IP", text: $locationViewModel.ip)
                                .padding()
                                .background(Color.white)
                                .frame(width: 300, height: 50)
                                .cornerRadius(10)
                            
                    Text("e.g 172.16.0.167")
                        .frame(width: 300, alignment: .leading)
                        .font(.system(size: 15))
                        .opacity(0.2)
                }
                    
                VStack{
                    Button(action: {
                        locationViewModel.fetchData()
                    },
                           label: {
                        Text("Show Location Info from IP!")
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
            .navigationBarTitle("IP Info Location", displayMode: .inline)
        }
            
    }
}

struct IpInfoView_Previews: PreviewProvider {
    static var previews: some View {
        IpInfoView()
    }
}
