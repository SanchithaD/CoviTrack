//
//  MapView.swift
//  MetricTest
//
//  Created by mihika on 8/9/20.
//  Copyright © 2020 mihika. All rights reserved.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        VStack{
            Text("Symptoms")
                .font(.title)
                .fontWeight(.thin)
                .frame(width: 150.0)
                .background(Color.purple.opacity(0.5))
                .cornerRadius(10)
            
            Image("symptoms")
            
            Text("Emergency")
            .font(.title)
                .fontWeight(.thin)
            .frame(width: 150.0)
            .background(Color.purple.opacity(0.5))
            .cornerRadius(10)
            
            Image("emergency")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
