//
//  ProfileFormView.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/22.
//

import SwiftUI

struct ProfileFormView: View {
    @State private var nickname = ""
    @State private var contract = ""
    @State private var genderTag = 0
    @State private var gender: Gender = .male
    @State private var age: Age = .teen
    @State private var carType: CarType = .compactCar
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 20){
                HStack{
                    Text("개인 정보 입력").font(.system(size:30, weight: .bold))
                    Spacer()
                }.padding(.bottom, 30)
               
                
                //공통된 입력
                TextField("닉네임", text: $nickname)
                    .textFieldStyle(.roundedBorder)
                TextField("연락처", text: $contract)
                    .textFieldStyle(.roundedBorder)
                
                //여행자일 때
                Picker("", selection: $genderTag){
                    ForEach(0 ..< Gender.allCases.count, id:\.self){
                        Text("\(Gender.allCases[$0].rawValue)").tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Picker("", selection: $age){
                    ForEach(0 ..< Age.allCases.count){
                        Text("\(Age.allCases[$0].rawValue)대")
                    }
                }.pickerStyle(.wheel)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.15), lineWidth: 1))
                
                
                //기사일 때
                Picker("", selection: $carType){
                    ForEach(0 ..< CarType.allCases.count){
                        Text("\(CarType.allCases[$0].rawValue)")
                    }
                }.pickerStyle(.wheel)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.15), lineWidth: 1))
                
                Button{
                    
                }label: {
                    Text("작성 완료")
                        .font(.system(size: 18, weight:.bold))
                        .frame(maxWidth:.infinity)
                }.padding().foregroundColor(.white)
                    .background(Color.appColor)
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal)
        .padding(.top, 50)
        .onAppear{
            UIScrollView.appearance().bounces = false
        }
    }
    
}

struct ProfileFormView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFormView()
    }
}
