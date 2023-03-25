//
//  NFCTagPayload.swift
//  DomajamApp
//
//  Created by Yutaro Muta on 2023/03/25.
//

import Foundation

enum NFCTagPayload: String {
    case foo = "foofoofoofoofoo"
    case bar = "barbarbarbarbar"
    case baz = "bazbazbazbazbaz"

    var mile: Int {
        switch self {
        case .foo:
            return 30
        case .bar:
            return 50
        case .baz:
            return 100
        }
    }
}
