//
//  LeagueEntryDTO.swift
//  LoLWidget
//
//  Created by JK on 2022/01/30.
//

import Foundation

// MARK: - LeagueEntryDTO

/**
 사용자의 랭크(리그) 게임 등급에 관한 정보
 
 - `leagueID` : 경기 id
 - `queueType` : 큐 타입 ( 랭크, TFT )
 - `tier` : 티어 (숫자)
 - `rank` :  티어 (등급) ex. 아이언, 브론즈, 실버, ...
 - `summonerID` :  소환사 ID
 - `summonerName` : 소환사 이름
 - `leaguePoints` : 현재 경기 포인트
 - `wins`, `losses` : 승 / 패 수
 */

struct LeagueEntryDTO: Codable {
    let leagueID: String?
    let queueType: String
    let tier, rank: String?
    let summonerID, summonerName: String
    let leaguePoints, wins, losses: Int
    let veteran, inactive, freshBlood, hotStreak: Bool

    enum CodingKeys: String, CodingKey {
        case leagueID = "leagueId"
        case queueType, tier, rank
        case summonerID = "summonerId"
        case summonerName, leaguePoints, wins, losses, veteran, inactive, freshBlood, hotStreak
    }
}
