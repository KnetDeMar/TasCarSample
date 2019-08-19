//
//  CarImageEntity.swift
//  TasCar
//
//  Created by Enrique Canedo on 18/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

struct CarImageEntity: Decodable {
    
    let status: String
    let data: DataEntity?
    
}

struct DataEntity: Decodable {
    
    let result: ResultEntity
    
}

struct ResultEntity: Decodable {
    
    let total: Int?
    let items: [ItemEntity]
    
}

struct ItemEntity: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case type
        case media
        case desc
        case width
        case height
        case url
        case mediaFull = "media_fullsize"
    }
    
    let title: String
    let type: String
    let media: String
    let desc: String
    let width: String
    let height: String
    let url: String
    let mediaFull: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        type = try values.decode(String.self, forKey: .type)
        media = try values.decode(String.self, forKey: .media)
        desc = try values.decode(String.self, forKey: .desc)
        width = try values.decode(String.self, forKey: .width)
        height = try values.decode(String.self, forKey: .height)
        url = try values.decode(String.self, forKey: .url)
        mediaFull = try values.decode(String.self, forKey: .mediaFull)
    }
    
}
