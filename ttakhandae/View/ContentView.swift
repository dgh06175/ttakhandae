//
//  ContentView.swift
//  ttakhandae
//
//  Created by 이상현 on 8/8/24.
//

import SwiftUI

struct MainView: View {
    @AppStorage("cigaretteInterval") private var cigaretteInterval: Int = 1
    @AppStorage("firstAppLaunchTimeString") private var firstAppLaunchTimeString: String = ""
    @AppStorage("cigaretteCount") private var cigaretteCount: Int = 1

    init() {
        if firstAppLaunchTimeString.isEmpty {
            firstAppLaunchTimeString = ISO8601DateFormatter().string(from: Date())
        }
    }
    
    @State private var timer: Timer?
    @State private var isPickerPresented = false
    @State private var lastUpdateTime: Date = Date()
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("설정된 빈도: \(cigaretteInterval) 일에 따악 한대")
                Spacer()
                Button(action: { isPickerPresented.toggle() }, label: {
                    HStack {
                        Image(systemName: "gear")
                    }
                })
            }
            Text("현재 피울 수 있는 담배: \(cigaretteCount) 개")
                .font(.title)
            
            Button(action: {
                cigaretteCount -= 1
            }) {
                Text("담배 피웠다!")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .sheet(isPresented: $isPickerPresented) {
            PickerView()
            .presentationDetents([.height(240)])
        }
        .onAppear {
//            loadLastUpdateTime() // 앱 시작 시 마지막 업데이트 시간 로드
//            setupTimer() // 타이머 설정
        }
    }
}



#Preview {
    MainView()
}
