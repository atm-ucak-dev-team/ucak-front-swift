//
//  DashboardView.swift
//  UcakFront
//
//  Created by DIMAS DAFFA ERNANDA on 17/05/26.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationStack(){
            VStack(){
                DummyCardView()
                Spacer()
            }
            .navigationTitle("Follup")
        }
    }
}

#Preview {
    DashboardView()
}
