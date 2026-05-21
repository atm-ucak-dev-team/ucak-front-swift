////
////  SummaryListJobCardView.swift
////  FollupApp
////
////  Created by Eileen Anindya on 21/05/26.
////
//
//import SwiftUI
//
//struct SummaryListJobCardView: View {
//    var items: [SummaryListJobItem] = []
//    
//    init(items: [SummaryListJobItem]? = nil){
//        if let items = items, !items.isEmpty{
//            self.items = items
//        } else{
//            self.items = [
//                SummaryListJobItem(icon: "checkmark", title: "Replied", count: 0),
//                SummaryListJobItem(icon: "hourglass", title: "Ongoing", count: 0),
//                SummaryListJobItem(icon: "trash", title: "Expired", count: 0)
//            ]
//        }
//    }
//    var body: some View {
//        HStack {
//            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
//                if index > 0 {
//                    Divider()
//                        .frame(height: 90)
//                }
//                
//                Spacer()
//                VStack(spacing: 10) {
//                    Image(systemName: item.icon)
//                        .font(.system(size: 16, weight: .medium))
//                    Text("\(item.count)")
//                        .font(.system(size: 28, weight: .bold))
//                    Text(item.title)
//                        .font(.system(size: 16, weight: .medium))
//                }
//                Spacer()
//            }
//        }
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .padding(30)
//        .background(Color.themeBackground)
//        .cornerRadius(26)
//    }
//}
//
//#Preview("With Data"){
//    SummaryListJobCardView(
//        items: [
//            SummaryListJobItem(icon: "checkmark", title: "Replied", count: 2),
//            SummaryListJobItem(icon: "hourglass", title: "Ongoing", count: 1),
//            SummaryListJobItem(icon: "trash", title: "Expired", count: 3)
//        ]
//    )
//}
//
//#Preview("Empty"){
//    SummaryListJobCardView()
//}
