//
//  SummonerDTO.swift
//  LoLWidget
//
//  Created by JK on 2022/01/30.
//

import Alamofire
import Foundation
import Moya

/**
 소환사에 관한 정보

 - `id` : 소환사 고유 Id (encrypted)
 - `accountID` : 계정 id (encrypted)
 - `name` : 소환사 이름
 - `summonerLevel` : 소환사 레벨
 - `puuid` : PUUID (encrypted)
 - `revisionDate` : 마지막 수정 날짜. (소환사 이름, 레벨, 프로필 아이콘)
 - `profileIconID` : 사용하는 프로필 아이콘의 고유 번호
 */

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
