//
//  EverythingApp.swift
//  Everything
//
//  Created by Ivan Pryhara on 19.09.22.
//

import SwiftUI

@main
struct EverythingApp: App {
    var body: some Scene {
        WindowGroup {
            StackOverView()
//                .frame(height: 300)
        }
    }
}


struct StackOverView: View {

    @State var currentTab: Int = 0
    @State var selectedTab: Int = 0
    @State var searchKeyword: String = ""
 var body: some View {

        ZStack(alignment: .top){
            
            
            VStack{
                HStack{
                    TextField("Enter search keyword", text: $searchKeyword)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .padding(.leading,20)
                    Button(action: {
                       self.currentTab = 0
                        print("New Current Index: ",self.currentTab)
                        
                    }, label: {
                       
                        Image(uiImage: UIImage(systemName: "gear")!)
                            .resizable()
                            .frame(width:24,height:24)
                            .padding(5)

                    })
                    

                }
                
//                ZStack(alignment: .top){
//                    TabBarView(currentTab: self.$currentTab)
//                }
                TabView(selection: self.$currentTab) {
                    EmptyView().tag(0)
                    EmptyView().tag(1)
                    EmptyView().tag(2)
                    EmptyView().tag(3)
                }
//                .environmentObject(viewModel)
                .tabViewStyle(.page(indexDisplayMode: .always))
                .edgesIgnoringSafeArea(.all)
                .onChange(of: self.currentTab, perform: { newValue in

                    self.selectedTab = newValue

                })
            }
        }
    
}

}
