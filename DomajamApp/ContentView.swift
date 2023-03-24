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
    let holder = "読み込んだ情報を表示"

    var body: some View {
        NavigationView {
            VStack(spacing: 30){
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 2)
                        )
                    TextField("読み込んだ情報を表示", text: self.$data)
                        .foregroundColor(self.data.isEmpty ? .gray : .black)
                        .padding()
                }.frame(height: UIScreen.main.bounds.height * 0.3)

                //Read Button
                NFCButton(data: self.$data)
                    .frame(height: UIScreen.main.bounds.height * 0.05)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
            }.frame(width: UIScreen.main.bounds.width * 0.9, alignment: .center)
            .navigationBarTitle("NFC Read/Write", displayMode: .large)
            .padding(.top, 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
