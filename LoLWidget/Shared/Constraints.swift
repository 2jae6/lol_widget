//
//  Constraints.swift
//  LoLWidget
//
//  Created by JK on 2022/01/30.
//

import Foundation

enum Constraints {
    static let RIOT_BASE_URL = "https://kr.api.riotgames.com"
    static let RIOT_API_KEY = Bundle.main.object(forInfoDictionaryKey: "RIOT_API_KEY") as! String
}
