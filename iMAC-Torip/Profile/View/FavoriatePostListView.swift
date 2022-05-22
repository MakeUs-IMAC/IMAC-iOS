//
//  interestingPostListView.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/22.
//

import SwiftUI

struct FavoriatePostListView: View {
    @EnvironmentObject private var viewModel: ProfileViewModel
    
    @State private var posts:[GetPosts] = []
    var body: some View {
        contentView
        .navigationTitle("관심목록")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
        .onAppear{
            viewModel.favoriatePostList{
                self.posts = $0
            }
            
            UINavigationBar.appearance().backgroundColor = .white
        }
    }
    
    @ViewBuilder
    var contentView: some View{
        if posts.count <= 0{
            VStack{
                Text("😂").font(.system(size: 100))
                    .padding(.bottom, 50)
                Text("관심 글로 지정해놓은\n글이 없네요..")
                    .font(.system(size: 30, weight: .bold))
                    .multilineTextAlignment(.center)
            }
            
        }
        else{
            List{
                
            }
        }
    }
}

struct FavoriatePostListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriatePostListView()
    }
}
