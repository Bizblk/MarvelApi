//
//  Extension + String.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 02.05.2021.
//

import CryptoKit

extension String {
var MD5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}
