//
//  TicketSummaryResponse.swift
//  FollupApp
//
//  Created by Eileen Anindya on 27/05/26.
//

import Foundation

struct TicketSummaryResponse: Decodable{
    let jiraTicketId: String
    let jiraTitle: String
    let replied: Int
    let ongoing: Int
    let expired: Int
}
