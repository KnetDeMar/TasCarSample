//
//  Constants.swift
//  TasCar
//
//  Created by Enrique Canedo on 08/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit
import RealmSwift
import CommonCrypto

// MARK: - Constants

struct Constants {
    
    static let shadowLayerName = "SHADOW_BORDER_LAYER_NAME"
    static let cornerLayerName = "CORNER_LAYER_NAME"
    static let gradientLayerName = "GRADIENT_LAYER_NAME"
    static let imageDownloaderTask = "TASK_IMAGE_DOWNLOAD"
    static let radius: CGFloat = 25.0
    static let borderWidthDefault: CGFloat = 2.0
    static let shadowCornerDefault: CGFloat = 3.0
    static let animationDuration = 0.6
    static let shadowSize = CGSize(width: 1.0, height: 1.0)
    static let yearSeparator: Character = "-"
    static let privacyUrl = "https://www.google.com"
    static let valueSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter
    }()
    
}

// MARK: - Connection

struct Connection {
    
    static let retries = 2
    
}

// MARK: - File

struct Files {
    
    static let fileBrands = "brands"
    static let fileExtension = "json"
    static let fileEmpty = "empty"
    static let fileGif = "tascar"
    static let fileGifExtension = "gif"
    
}

// MARK: - Animate files

struct Animation {
    
    static let timeInterval = 0.1
    static let layers: [String] = {
        return (1...13).map { index in return "\(Files.fileGif)\(index)" }
    }()
    
}

// MARK: - Realm Configurations

#if REALM

struct RealmConfiguration {
    
    static private let bundle = Bundle.main.url(forResource: "tascar", withExtension: "realm")
    static private let publicKey: Data? = RealmConfiguration.sha512(key: "com.knetdemar.tascar.realm")
    static let config = Realm.Configuration(fileURL: RealmConfiguration.bundle, encryptionKey: RealmConfiguration.publicKey, readOnly: true)
    
    // MARK: - Private static functions
    
    static private func sha512(key: String) -> Data? {
        guard let stringData = key.data(using: .utf8) else { return nil }
        
        var result = Data(count: Int(CC_SHA512_DIGEST_LENGTH))
        _ = result.withUnsafeMutableBytes { resultBytes in
            stringData.withUnsafeBytes { stringBytes in
                CC_SHA512(stringBytes, CC_LONG(stringData.count), resultBytes)
            }
        }
        return result
    }
    
}

#endif
