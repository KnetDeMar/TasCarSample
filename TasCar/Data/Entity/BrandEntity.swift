//
//  BrandEntity.swift
//  TasCar
//
//  Created by Enrique Canedo on 08/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

#if REALM

import RealmSwift

class BrandEntity: Object {
    
    @objc dynamic var idBrand: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var file: String?
    @objc dynamic var color: String?
    
    convenience init(idBrand: Int, name: String?, file: String?, color: String?) {
        self.init()
        
        self.idBrand = idBrand
        self.name = name
        self.file = file
        self.color = color
    }
    
    override static func primaryKey() -> String? {
        return "idBrand"
    }
    
}

#else

struct BrandEntity: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case file
        case hexColor
    }
    
    let name: String?
    let file: String?
    let color: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        file = try values.decode(String.self, forKey: .file)
        color = try values.decode(String.self, forKey: .hexColor)
    }
    
}

#endif
