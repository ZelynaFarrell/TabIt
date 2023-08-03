//
//  AuthError.swift
//  TabIt
//
//  Created by Zelyna Sillas on 7/26/23.
//

import Foundation

struct AuthError: Identifiable, Equatable {
    let id = UUID()
    let message: String

    static func == (lhs: AuthError, rhs: AuthError) -> Bool {
        return lhs.id == rhs.id && lhs.message == rhs.message
    }
}
