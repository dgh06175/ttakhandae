//
//  StartView.swift
//  ttakhandae
//
//  Created by 이상현 on 8/8/24.
//

import SwiftUI

struct StartView: View {
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    @State private var isPickerPresented: Bool = true

    var body: some View {
        if isFirstLaunch {
            PickerView(isPickerPresented: $isPickerPresented)
        } else {
            MainView()
        }
    }
}

#Preview {
    StartView()
}
