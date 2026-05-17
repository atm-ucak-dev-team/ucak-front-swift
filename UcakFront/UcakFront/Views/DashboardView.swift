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
                Text("Halo dunia")
            }
            .navigationTitle("UcakFront")
        }
    }
}

#Preview {
    DashboardView()
}
