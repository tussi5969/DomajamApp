//
//  NFCTagPayload.swift
//  DomajamApp
//
//  Created by Yutaro Muta on 2023/03/25.
//

import Foundation

enum NFCTagPayload: String {
    case onsen = "foofoofoofoofoo"
    case harikoshi = "barbarbarbarbar"
    case gioHillsWinery = "bazbazbazbazbaz"

    var mile: Int {
        switch self {
        case .onsen:
            return 30
        case .harikoshi:
            return 50
        case .gioHillsWinery:
            return 100
        }
    }

    var text: String {
        switch self {
        case .onsen:
            return "初恋りんご風呂"
        case .harikoshi:
            return "はりこし亭"
        case .gioHillsWinery:
            return "ジオヒルズワイナリー"
        }
    }

}
