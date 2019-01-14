//
//  Cryptor.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 18/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit
import RNCryptor

class Cryptor: NSObject {
    
    static let share = Cryptor()
    private let key = "WsiHRxmMp8WrgFfRzmtLmyKAdeFd"
    
    func encryptMessage(message: String, encryptionKey: String? = nil) throws -> String {
        let messageData = message.data(using: .utf8)!
        let cipherData = RNCryptor.encrypt(data: messageData, withPassword: encryptionKey ?? key)
        return cipherData.base64EncodedString()
    }
    func decryptMessage(encryptedMessage: String, encryptionKey: String? = nil) throws -> String {
        
        let encryptedData = Data.init(base64Encoded: encryptedMessage)!
        let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: encryptionKey ?? key)
        let decryptedString = String(data: decryptedData, encoding: .utf8)!
        
        return decryptedString
    }
    func generateEncryptionKey(withPassword password:String) throws -> String {
        let randomData = RNCryptor.randomData(ofLength: 32)
        let cipherData = RNCryptor.encrypt(data: randomData, withPassword: password)
        
        return cipherData.base64EncodedString()
    }
}
