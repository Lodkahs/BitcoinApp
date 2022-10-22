//
//  BoitcoinData.swift
//  ByteCoin
//
//  Created by Andrew  on 10/22/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct BitcoinData: Codable {
    var time: String
    var asset_id_base: String
    var asset_id_quote: String
    var rate: Double
}
