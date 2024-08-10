//
//  PickerView.swift
//  ttakhandae
//
//  Created by 이상현 on 8/10/24.
//

import SwiftUI

struct PickerView: View {
    @AppStorage("cigaretteInterval") private var cigaretteInterval: Int = 1
    @Binding var isPickerPresented: Bool
    @State var pickNumber: Int = 1
    
    var body: some View {
        VStack {
            Text("담배를 며칠에 딱 한대씩 피우실 건가요?")
                .font(.title3)
            Picker("빈도", selection: $pickNumber) {
                ForEach(1..<31) { days in
                    Text("\(days)일").tag(days)
                }
            }
            .pickerStyle(WheelPickerStyle())
            Button(action: {
                UserDefaults.standard.set(false, forKey: "isFirstLaunch")
                cigaretteInterval = pickNumber
                isPickerPresented = false
            } ){
                Text("확인")
            }
        }
        .padding()
        .onAppear {
            pickNumber = cigaretteInterval
        }
    }
}
