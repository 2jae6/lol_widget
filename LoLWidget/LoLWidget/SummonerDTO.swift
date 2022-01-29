//
//  SummonerDTO.swift
//  LoLWidget
//
//  Created by JK on 2022/01/30.
//

import Foundation
import Alamofire
import Moya

// MARK: - SummonerDTO
struct SummonerDTO: Codable {
    let id, accountID, puuid, name: String
    let profileIconID, revisionDate, summonerLevel: Int

    enum CodingKeys: String, CodingKey {
        case id
        case accountID = "accountId"
        case puuid, name
        case profileIconID = "profileIconId"
        case revisionDate, summonerLevel
    }
}
