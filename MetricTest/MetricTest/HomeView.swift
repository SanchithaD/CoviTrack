//
//  HomeView.swift
//  SwiftUITabView
//
//  Created by mihika on 8/8/20.
//  Copyright © 2020 Rebeloper. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
       
        Home()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct Home : View {
    
    @ObservedObject var data = getData()
    var body : some View {
        
        VStack{
            
            if self.data.countries.count != 0 && self.data.data != nil{
                
                VStack{
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 15) {
                
                
                            Text(getDate(time: self.data.data.updated))
                                .fontWeight(.semibold).foregroundColor(.white).padding(.trailing)
                            
                            Text("Cases")
                                .fontWeight(.semibold).foregroundColor(.white).padding(.trailing)
                            
                            Text(getValue(data: self.data.data.cases))
                                .fontWeight(.bold)
                                .font(.title).foregroundColor(.white)
                                
                            
                            
                        }
                        
                        Button(action: {
                            
                            self.data.data = nil
                            self.data.countries.removeAll()
                            self.data.updateData()
                            
                        }) {
                            Image(systemName: "arrow.clockwise").padding(.leading, 80).font(.title).foregroundColor(.white)
                        }
                    }
                    .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 18)
                    .padding()
                    .padding([.leading, .bottom, .trailing], 80)
                    .frame(width: 1000.0)
                    .background(Color.purple.opacity(0.5))
                    
                    HStack(spacing: 15){
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text("Deaths")
                                .foregroundColor(Color.black.opacity(0.5))
                            
                            Text(getValue(data: self.data.data.deaths))
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.purple)
                            
                        }
                            .padding(30)
                            .background(Color.white)
                        .cornerRadius(12)
                        
                        VStack(alignment: .leading, spacing: 15) {
                        
                            Text("Recovered")
                            .foregroundColor(Color.black.opacity(0.5))
                        
                            Text(getValue(data: self.data.data.recovered))
                            .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.purple)
                        
                        }
                        .padding(30)
                        .background(Color.white)
                    .cornerRadius(12)
                        
                    }
                    .offset(y: -60)
                    .padding(.bottom, -60)
                    .zIndex(25)
                    
                    VStack(alignment: .center, spacing: 15) {
                        
                        Text("Active Cases")
                            .foregroundColor(Color.black.opacity(0.5))
                        
                        Text(getValue(data: self.data.data.active))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.purple)
                        
                    }
                        .padding(30)
                        .background(Color.white)
                    .cornerRadius(12)
                        .padding(.top, 15)
                    
                    ScrollView(.horizontal, showsIndicators : false) {
                        
                        HStack(spacing: 15){
                            ForEach(self.data.countries,id: \.self){ i in
                                
                                cellView(data: i)
                                
                            }
                        }
                    .padding()
                    }
                    
                }
            }
            else {
                
                GeometryReader{_ in
                    
                    VStack{
                        
                        Indicator()
                    }
                }
            }
            
        }.edgesIgnoringSafeArea(.top)
            .background(Color.black.opacity(0.1).edgesIgnoringSafeArea(.all))
    }
}

func getDate(time : Double)->String{
    let date = Double(time / 1000)
    
    let format = DateFormatter()
    format.dateFormat = "MMM - dd - YYYY hh:mm a"
    return format.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: date)!))
}

func getValue(data : Double)->String {
    let format = NumberFormatter()
    format.numberStyle = .decimal
    
    return format.string(for: data)!
}

struct cellView : View {
    
    var data : Details
    var body : some View {
        
        VStack(alignment: .leading, spacing: 15) {
            
            Text(data.country).fontWeight(.bold)
            
            HStack(spacing: 22) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Active Cases").font(.title)
                    
                    Text(getValue(data: data.cases)).font(.title)
            }
                
            VStack(alignment: .leading, spacing: 12) {
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Deaths")
                    
                    Text(getValue(data: data.deaths)).foregroundColor(.red)
            
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Recovered")
                        
                        Text(getValue(data: data.recovered)).foregroundColor(.green)
                
                    }
                    
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Critical")
                        
                        Text(getValue(data: data.critical)).foregroundColor(.yellow)
                
                    }
                    
            }
            
        }
      }
    .padding()
        .frame(width: UIScreen.main.bounds.width - 30)
        .background(Color.white)
    .cornerRadius(20)
   }
}



struct Case : Decodable {
    var cases : Double
    var deaths : Double
    var updated : Double
    var recovered : Double
    var active : Double
}

struct Details : Decodable,Hashable {
    var country : String
    var cases : Double
    var deaths : Double
    var recovered : Double
    var critical : Double
}

class getData : ObservableObject {
    @Published var data : Case!
    @Published var countries = [Details]()
    
    init() {
        
        updateData()
        
    }
    
    func updateData(){
        
        let url = "https://corona.lmao.ninja/v2/all"
        let url1 = "https://corona.lmao.ninja/v2/countries/"
        
        let session = URLSession(configuration: .default)
        let session1 = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSONDecoder().decode(Case.self, from: data!)
            
            DispatchQueue.main.async {
                self.data = json
            }
            
        }.resume()
        
        for i in country{
            session1.dataTask(with: URL(string: url1+i)!) { (data, _, err) in
                       
                       if err != nil{
                           print((err?.localizedDescription)!)
                           return
                       }
                       
                       let json = try! JSONDecoder().decode(Details.self, from: data!)
                       
                       DispatchQueue.main.async {
                        self.countries.append(json)
                       }
                       
                   }.resume()
        }
        
       

    }
}

var country = ["usa", "italy","spain","australia","india","china"]


struct Indicator : UIViewRepresentable {
    
    
    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        
        let view = UIActivityIndicatorView(style : .large)
        view.startAnimating()
        return view
        
    }
    
    func updateUIView(_ uiView: Indicator.UIViewType, context: UIViewRepresentableContext<Indicator>) {
        
    }
}
