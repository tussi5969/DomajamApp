//
//  ContentView.swift
//  DomajamApp
//
//  Created by 宮地篤士 on 2023/03/23.
//

import SwiftUI
import CoreNFC

struct ContentView: View {
    @State var data = ""
    @State var showWrite = false
    @State var totalMile = 0
    let holder = "読み込んだ情報を表示"

    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground).ignoresSafeArea()
                VStack {
                    VStack(spacing: 30){
                        //                    ZStack(alignment: .topLeading) {
                        //                        RoundedRectangle(cornerRadius: 20)
                        //                            .foregroundColor(.white)
                        //                            .overlay(
                        //                                RoundedRectangle(cornerRadius: 20)
                        //                                    .stroke(Color.black, lineWidth: 2)
                        //                            )
                        //                        TextField("読み込んだ情報を表示", text: self.$data)
                        //                            .foregroundColor(self.data.isEmpty ? .gray : .black)
                        //                            .padding()
                        //                    }.frame(height: UIScreen.main.bounds.height * 0.3)
                        HStack {
                            Text("ユーザー")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        HStack {
                            TextField("0", text: $totalMile.IntToStrDef(0))
                                .multilineTextAlignment(TextAlignment.center)
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }.padding(.vertical, 6)
                        HStack {
                            Spacer()
                            Text("マイル")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        }
                    }
                    .padding(20)
                    .background(Color(#colorLiteral(red: 0.86, green: 0.48, blue: 0.69, alpha: 1)))
                    .cornerRadius(12)
                    .clipped()
                    .shadow(color: .gray.opacity(0.7), radius: 5)
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    
                    HStack {
                        CustomButton(title: "ワインを買う", imageName: "wine", mile: 10, totalMile: $totalMile)
                        Spacer()
                        CustomButton(title: "中棚荘宿泊", imageName: "onsen", mile: 50, totalMile: $totalMile)
                    }.padding(EdgeInsets(
                        top: 20,
                        leading: 30,
                        bottom: 10,
                        trailing: 30
                    ))
                    HStack {
                        Spacer()
                        CustomButton(title: "マイルを使う", imageName: "miles", mile:0, totalMile: $totalMile)
                        Spacer()
                    }.padding(EdgeInsets(
                        top: 10,
                        leading: 30,
                        bottom: 20,
                        trailing: 30
                    ))

                    VStack {
                        NFCButton(data: self.$data)
                            .frame(height: UIScreen.main.bounds.height * 0.05)
                            .clipShape(RoundedRectangle(cornerRadius: 0))
                    }.frame(width: UIScreen.main.bounds.width * 0.9, alignment: .center)
                    Spacer()
                }.padding(.top, 30)
            }
        }
    }
}

struct CustomButton: View {
    var title: String = ""
    var imageName: String = ""
    var mile: Int = 0
    @Binding var totalMile: Int
    var body: some View {
        Button(action: {
            totalMile += mile
        }) {
            VStack {
                Image(self.imageName)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.width * 0.3)
                    .padding(.bottom, 10)
                Text(self.title)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .fontWeight(.bold)
            }.padding(16)
        }
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Binding where Value == Int {
    func IntToStrDef(_ def: Int) -> Binding<String> {
        return Binding<String>(get: {
            return String(self.wrappedValue)
        }) { value in
            self.wrappedValue = Int(value) ?? def
        }
    }
}
