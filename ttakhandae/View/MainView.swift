//
//  ContentView.swift
//  ttakhandae
//
//  Created by 이상현 on 8/8/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Query private var smokeRecords: [SmokeRecord]
    @Environment(\.modelContext) private var modelContext
    
    @AppStorage("cigaretteInterval") private var cigaretteInterval: Int = 3
    @AppStorage("firstAppLaunchTimeString") private var firstAppLaunchTimeString: String = ""
    @AppStorage("cigaretteCount") private var cigaretteCount: Int = 1
    
    init() {
        if firstAppLaunchTimeString.isEmpty {
            firstAppLaunchTimeString = ISO8601DateFormatter().string(from: Date())
        }
        updateCigaretteCount()
    }
    
    @State private var isPickerPresented = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                CalendarView(smokeRecords: smokeRecords)
                Spacer()
                Text("현재 피울 수 있는 담배")
                    .font(.title2)
                Text("\(cigaretteDisplay(smokeRecords: smokeRecords))")
                    .font(.title)
                SmokeButton(cigaretteCount: $cigaretteCount, smokeRecords: smokeRecords, recordSmoke: recordSmoke)
                Spacer()
            }
            .padding()
            .navigationTitle("딱 한 대")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { isPickerPresented.toggle() }, label: {
                        HStack {
                            Text("\(cigaretteInterval)일에 따아악 한 대")
                            Image(systemName: "gear")
                        }
                    })
                }
            }
            .sheet(isPresented: $isPickerPresented) {
                PickerView(isPickerPresented: $isPickerPresented)
                    .presentationDetents([.height(240)])
            }
        }
    }
    
    private func cigaretteDisplay(smokeRecords: [SmokeRecord]) -> String {
        let displaySmokeIconCount = 5
        let canSmokeCount = calcHowMuchCanISmoke(smokeRecords: smokeRecords)
        
        if canSmokeCount > displaySmokeIconCount {
            return String(repeating: "🚬 ", count: displaySmokeIconCount) + "... (\(canSmokeCount))"
        } else if canSmokeCount > 0{
            return String(repeating: "🚬 ", count: canSmokeCount)
        } else {
            return "\(canSmokeCount)"
        }
    }
    
    private func calcHowMuchCanISmoke(smokeRecords: [SmokeRecord]) -> Int {
        var smokeCount = 0
        for smokeRecord in smokeRecords {
            smokeCount += smokeRecord.count
        }
        return cigaretteCount - smokeCount
    }
    
    private func recordSmoke() {
        if let existingRecord = smokeRecords.first(where: { $0.date.isSameDate(date: Date()) }) {
            existingRecord.count += 1
        } else {
            modelContext.insert(SmokeRecord(date: Date(), count: 1))
        }
    }
    
    private func updateCigaretteCount() {
        guard let launchDate = ISO8601DateFormatter().date(from: firstAppLaunchTimeString) else { return }
        let daysSinceLaunch = Calendar.current.dateComponents([.day], from: launchDate, to: Date()).day ?? 0
        cigaretteCount = 1 + daysSinceLaunch / cigaretteInterval
    }
}

struct SmokeButton: View {
    @Binding var cigaretteCount: Int
    var smokeRecords: [SmokeRecord]
    let recordSmoke: () -> Void
    @State private var showAlert = false
    
    var body: some View {
        Button(action: {
            showAlert = true
        }) {
            Text("담배 피웠다! 💨")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .alert("정말 담배를 피우셨나요?", isPresented: $showAlert) {
            Button("취소", role: .cancel) { }
            Button("확인", role: .destructive) {
                recordSmoke()
            }
        }
    }
}



#Preview {
    MainView()
//        .modelContainer(sampleData)
        .modelContainer(for: SmokeRecord.self)
}
