//
//  LeagueEntryDTO.swift
//  LoLWidget
//
//  Created by JK on 2022/01/30.
//

import Foundation

// MARK: - LeagueEntryDTO

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
