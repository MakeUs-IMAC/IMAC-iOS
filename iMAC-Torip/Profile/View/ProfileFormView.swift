//
//  ProfileFormView.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/22.
//

import SwiftUI

struct ProfileFormView: View {
    @EnvironmentObject private var viewModel: ProfileViewModel
    
    @State private var nickname = ""
    @State private var contract = ""
    @State private var roleTag = 0
    @State private var genderTag = 0
    @State private var ageTag = 0
    @State private var carTypeTag = 0
    @State private var shouldShowNextView = false
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 20){
                HStack{
                    Text("개인 정보 입력").font(.system(size:30, weight: .bold))
                    Spacer()
                }.padding(.bottom, 30)
                
                //역할 선택
                Picker("", selection: $roleTag){
                    ForEach(0 ..< UserRole.allCases.count, id:\.self){
                        Text("\(UserRole.allCases[$0].rawValue)").tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: roleTag){
                    viewModel.role = UserRole.allCases[$0]
                }
                
                //공통된 입력
                TextField("닉네임", text: $nickname)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: nickname){
                        viewModel.nickname = $0
                    }
                TextField("연락처", text: $contract)
                    .textFieldStyle(.roundedBorder).onChange(of: contract){
                        viewModel.contract = $0
                    }
                
                if UserRole.allCases[roleTag] == UserRole.traveler {
                    //여행자일 때
                    Picker("", selection: $genderTag){
                        ForEach(0 ..< Gender.allCases.count, id:\.self){
                            Text("\(Gender.allCases[$0].rawValue)").tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: genderTag){
                        viewModel.gender = Gender.allCases[$0]
                    }
                    
                    Picker("", selection: $ageTag){
                        ForEach(0 ..< Age.allCases.count){
                            Text("\(Age.allCases[$0].rawValue)대").tag($0)
                        }
                    }.pickerStyle(.wheel)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.15), lineWidth: 1))
                        .onChange(of: ageTag){
                            viewModel.age = Age.allCases[$0]
                        }
                }
                else{
                    //기사일 때
                    Picker("", selection: $carTypeTag){
                        ForEach(0 ..< CarType.allCases.count){
                            Text("\(CarType.allCases[$0].rawValue)").tag($0)
                        }
                    }.pickerStyle(.wheel)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.15), lineWidth: 1))
                        .onChange(of: carTypeTag){
                            viewModel.carType = CarType.allCases[$0]
                        }
                }
                Button{
                    print("\(viewModel.role) \(viewModel.nickname) \(viewModel.contract) \(viewModel.age) \(viewModel.carType)")
                    viewModel.registProfile{
                        shouldShowNextView = $0
                    }
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
        }.fullScreenCover(isPresented: $shouldShowNextView){
            TabBarViewUIRepresentable()
        }
    }
    
}

struct ProfileFormView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFormView()
    }
}
