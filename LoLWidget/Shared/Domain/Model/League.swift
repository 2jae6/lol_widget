//
//  League.swift
//  LoLWidget
//
//  Created by JK on 2022/02/03.
//

import Foundation

struct League {
    var summonerName: String
    var queue: QueueType
    var tier: Tier?
    var points: Int
    var wins: Int
    var losses: Int
}

extension League {

    var winRate: Double {
        Double(wins) / Double(wins + losses)
    }

    static func from(dto: LeagueEntryDTO) -> League? {
        guard let queue = QueueType(rawValue: dto.queueType) else {
            assertionFailure()
            return nil
        }

        let tier = Tier.from(tier: dto.tier, rank: dto.rank)

        return League(summonerName: dto.summonerName, queue: queue, tier: tier, points: dto.leaguePoints, wins: dto.wins, losses: dto.losses)
    }
}

extension League {

    enum QueueType: String {
        case rankSolo = "RANKED_SOLO_5x5"
        case rankTeam = "RANKED_TEAM_5x5"
        case tftRank = "RANKED_TFT_PAIRS"
    }

    struct Tier {
        enum Grade: String {
            case iron
            case bronze
            case silver
            case gold
            case platinum
            case diamond
            case master
            case grandmaster
            case challenger
        }

        var tier: Grade
        var rank: Int?

        static func from(tier: String?, rank: String?) -> Tier? {
            guard let _tier = tier, let tier = Grade(rawValue: _tier.lowercased()) else {
                return nil
            }

            let rankNum: Int?
            if let _rank = rank {
                rankNum = [ "", "I", "II", "III", "IV" ].firstIndex(of: _rank)
            } else {
                rankNum = nil
            }

            return Tier(tier: tier, rank: rankNum)
        }
    }
}
