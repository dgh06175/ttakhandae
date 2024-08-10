//
//  SmokeCalenderView.swift
//  ttakhandae
//
//  Created by 이상현 on 8/10/24.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @State var month: Date = Date()
    var smokeRecords: [SmokeRecord]
    
    var body: some View {
        VStack {
            headerView
                .padding(18)
            weekDayView
                .padding(.horizontal)
            calendarGridView
                .padding(.horizontal)
                .padding(.bottom)
        }
        .animation(.linear(duration: 0.1) ,value:month)
    }
    
    // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack {
            HStack (spacing: 30) {
                Text(month.formattedDateYearMonth())
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Button(action: {changeMonth(by: -1)}, label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12)
                })
                Button(action: {changeMonth(by: 1)}, label: {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12)
                })
            }
        }
    }
    
    // MARK: - 월화수목금토일 뷰
    private var weekDayView: some View {
        HStack {
            ForEach(Self.weekdaySymbolsKR, id: \.self) { symbol in
                Text(symbol)
                    .foregroundStyle(Color.gray)
                    .opacity(0.6)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        
        return VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(0 ..< daysInMonth + firstWeekday, id: \.self) { index in
                    if index < firstWeekday {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.clear)
                    } else {
                        let date = getDate(for: index - firstWeekday)
                        let day = index - firstWeekday + 1
                        //let clicked = workoutDates.contains(date)
                        let record = workoutRecordByDate(for: date)
                        
                        CellView(cellDate: date, day: day, record: record)
                    }
                }
            }
        }
    }
}

// MARK: - 일자 셀 뷰
private struct CellView: View {
    let cellDate: Date
    var day: Int
    var record: SmokeRecord?
    
    init(cellDate: Date, day: Int, record: SmokeRecord?) {
        self.cellDate = cellDate
        self.day = day
        self.record = record
    }
    
    var body: some View {
        ZStack {
            if isSameDate(Date(), cellDate) {
                Circle()
                    .fill(Color.blue)
                    .opacity(0.3)
            }
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.clear)
                .overlay(Text(String(day)))
            Group {
                if record != nil {
                    switch record?.count {
                    case 0:
                        Circle()
                            .fill(Color.red)
                            .opacity(0.0)
                    case 1:
                        Circle()
                            .fill(Color.red)
                            .opacity(0.3)
                    case 2:
                        Circle()
                            .fill(Color.red)
                            .opacity(0.5)
                    case 3:
                        Circle()
                            .fill(Color.red)
                            .opacity(0.7)
                    default:
                        Circle()
                            .fill(Color.red)
                            .opacity(0.9)
                    }
                }
            }
        }
        .scaledToFit()
    }
    
    /// 같은 날짜인지 년, 월, 일 비교
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
        return date1.isSameDate(date: date2)
    }
}

// MARK: - 내부 메서드
private extension CalendarView {
    /// 특정 해당 날짜
    private func getDate(for day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth())!
    }
    
    /// 해당 월의 시작 날짜
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        return Calendar.current.date(from: components)!
    }
    
    /// 해당 월에 존재하는 일자 수
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    /// 월 변경
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: month) {
            self.month = newMonth
        }
    }
    
    /// 날짜에 맞는 기록 찾기
    func workoutRecordByDate(for date: Date) -> SmokeRecord? {
        return smokeRecords.first(
            where: { $0.date.startOfDay() == date.startOfDay() }
        )
    }
}

// MARK: - Static 프로퍼티
extension CalendarView {
    
    static let weekdaySymbolsKR = ["일", "월", "화", "수", "목", "금", "토"]
    static let weekdaySymbols = Calendar.current.shortStandaloneWeekdaySymbols
}

#Preview {
    MainView()
}
