//
//  EmailStateModel.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 28/05/26.
//

import Foundation

enum EmailThreadState {
    case idle
    case loading
    case loaded([EmailMessage])
    case failed(Error)
}

enum EmailState {
    case idle
    case loading
    case loaded(EmailMessage)
    case failed(Error)
}
