//
//  AlertView.swift
//  MetricTest
//
//  Created by mihika on 8/9/20.
//  Copyright © 2020 mihika. All rights reserved.
//

import SwiftUI

struct AlertView: View {
    @State private var showingAlert = false

    var body: some View {
        
        Button(action: {
            
            self.showingAlert = true
        }) {
            Text("Check Neighborhood")
            
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text("Uh oh! In Covid Exposed Area!"))
        }
    
    }
    
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}


