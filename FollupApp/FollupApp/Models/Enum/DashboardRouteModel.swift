//
//  DashboardRouteModel.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 25/05/26.
//

import Foundation

/// Defines all navigation destinations available from the Dashboard View.
/// Declared in the Model layer to keep Views purely presentational and routing unified.
enum DashboardRoute: Hashable {
    case allJobs
    case jobDetail(FollowUp)
    case ticketDetail(JiraTicketItem)
}
