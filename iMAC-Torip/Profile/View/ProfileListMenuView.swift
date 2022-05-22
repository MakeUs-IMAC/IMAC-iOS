//
//  ProfileListMenuView.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/22.
//

import SwiftUI

struct ProfileListMenuView: View {
    //    @EnvironmentObject private var viewModel: ProfileViewModel
    var body: some View {
        NavigationView{
            List{
                NavigationLink( destination: Text("")){
                    HStack{
                        Text("관심목록")
                        Spacer()
                    }
                }
                NavigationLink(destination: Text("")){
                    HStack{
                        Text("내가 쓴 글 목록")
                        Spacer()
                    }
                }
                NavigationLink(destination:Text("")){
                    HStack{
                        Text("프로필")
                        Spacer()
                    }
                }
                NavigationLink( destination: Text("")){
                    HStack{
                        Text("여행 관리")
                        Spacer()
                    }
                }
                
                
            }.listStyle(.grouped)
                .navigationTitle("")
                .navigationBarHidden(true)
        }.navigationViewStyle(.stack)
        
    }
}

struct ProfileListMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileListMenuView()
    }
}
