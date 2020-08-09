//
//  AppsView.swift
//  TabBarTutorial
//
//  Created by Alpar Matyas on 10/09/2019.
//  Copyright © 2019 Alpar Matyas. All rights reserved.
//

import SwiftUI

struct MainView: View {
        
    var body: some View {
        NavigationView{
        VStack{
            
            Image("logo")
                .cornerRadius(40)
            
            Text("CoviTracker")
                .font(.largeTitle)
                .fontWeight(.light)
                .padding(.top)
            
            Image("mapI")
            
            Spacer()
            HStack{
            
           
            NavigationLink(destination: MapView()) {
                Image(systemName: "mappin.and.ellipse")
                    .frame(width: 50, height: 50).foregroundColor(.white)
                .background(
                Color.purple.opacity(0.5))
                .cornerRadius(40)

            }
            
            NavigationLink(destination: AlertView()) {
                Image(systemName: "exclamationmark.bubble")
                    .frame(width: 50.0, height: 50.0).foregroundColor(.white)
                .background(
                Color.purple.opacity(0.5))
                .cornerRadius(40)
            }
            
            NavigationLink(destination: HomeView()) {
                Image(systemName: "chart.pie")
                    .padding(.leading).padding(.trailing)
                        .frame(width: 50, height: 50).foregroundColor(.white)
                    .background(
                    Color.purple.opacity(0.5))
                .cornerRadius(40)

            }
        }
            
        }
        .padding(.bottom)
        
        }
        .padding(.horizontal)
       
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

