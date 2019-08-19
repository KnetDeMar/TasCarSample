//
//  CarImage.swift
//  TasCar
//
//  Created by Enrique Canedo on 19/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import Foundation

final class CarImage {
    
    var images: [Media] = []
    
}

final class Media {
    
    var title: String = ""
    var type: String = ""
    var media: URL? 
    var width: Int = 0
    var height: Int = 0
    var link: URL?
    var mediaFullSize: URL?
    
}
