//
//  CountView.swift
//  muslimTools
//
//  Created by halsab on 10.11.2022.
//

import SwiftUI

struct CountView: View {

    @EnvironmentObject var appManager: AppManager
    @EnvironmentObject var countManager: CountManager

    var body: some View {
        Text("Hello world!")
    }
}

struct CountView_Previews: PreviewProvider {
    static var previews: some View {
        CountView()
            .environmentObject(AppManager())
            .environmentObject(CountManager())
    }
}
