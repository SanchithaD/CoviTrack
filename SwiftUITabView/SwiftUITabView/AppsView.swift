//
//  AppsView.swift
//  TabBarTutorial
//
//  Created by Alpar Matyas on 10/09/2019.
//  Copyright © 2019 Alpar Matyas. All rights reserved.
//

import SwiftUI

struct AppsView: View {
    
    @State var animation = true
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: { self.animation.toggle() }) {
            Text("CoviTrack")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .shadow(color: .gray, radius: 10, x: 0, y: 10)
            }
                .offset(y: animation ? UIScreen.main.bounds.height / 2.5 : 0)
                .animation(.easeInOut(duration: 2))
            
            Image("logo").cornerRadius(30)
                .padding()
                 .shadow(color: .gray, radius: 10, x: 0, y: 10)
            
                .opacity(animation ? 0 : 1)
                .animation(Animation.easeInOut(duration: 3))
        }
        .frame(minHeight: 0, maxHeight: .infinity)
        .padding(.horizontal, 20)
//        .onAppear { self.animation.toggle() }
    }
}

struct AppsView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
    }
}

