//
//  Token.swift
//  FollupApp
//
//  Created by Bomanarakasura on 22/05/26.
//
import Foundation

struct Token {
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
}

struct TokenParser {
    static func parse(from url: URL) -> Token? {
        guard
            let components = URLComponents(
                url: url,
                resolvingAgainstBaseURL: false
            ),
            let queryItems = components.queryItems
        else { return nil }

        let params = Dictionary(
            uniqueKeysWithValues: queryItems.compactMap {
                ($0.name, $0.value ?? "")
            }
        )

        guard let accessToken = params["access_token"],
            let refreshToken = params["refresh_token"],
            let expiresIn = params["expires_in"],
            !accessToken.isEmpty, !refreshToken.isEmpty, !expiresIn.isEmpty
        else { return nil }

        return Token(
            accessToken: accessToken,
            refreshToken: refreshToken,
            expiresIn: Int(expiresIn)!
        )
    }
}
