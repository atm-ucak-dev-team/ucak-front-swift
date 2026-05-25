//
//  JiraCardView.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 21/05/26.
//

import SwiftUI

struct JiraCardView: View {
    @State var viewModel: JiraTicketCardViewModel
    @State var items: [JiraTicketItem] = []
    
    var body: some View {
        ForEach (Array(items.enumerated()), id: \.element.id) { index, card in
            VStack (alignment: .leading, spacing: 12) {
                VStack (alignment: .leading, spacing: 12) {
                    JiraStatusLabelView(status: card.status ?? .unknown)
                    Text(card.title)
                        .frame(width: 150, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .font(Font.subheadline.weight(.regular))
                        .foregroundColor(.themeTypography)
                }
                
                Text(card.ticketKey)
                    .frame(width: 150, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .font(Font.caption.weight(.medium))
                    .foregroundColor(Color.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
        }
    }
}


#Preview ("With Data") {
    let vm = JiraTicketCardViewModel()
    vm.tickets = [
        JiraTicketItem(ticketKey: "ADA-001", title: "Jira Ticket", iconName: "circle.circle.fill", status: .done),
        JiraTicketItem(ticketKey: "ADA-002", title: "Jira Ticket 2", iconName: "balloon.2.fill", status: .inprogress)
    ]
    return JiraCardView(viewModel: vm, items: vm.tickets)
}

#Preview ("Empty View") {
    let vm = JiraTicketCardViewModel()
    return JiraCardView(viewModel: vm)
}
