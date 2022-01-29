//
//  RiotQuery.swift
//  LoLWidget
//
//  Created by JK on 2022/01/30.
//

import Foundation
import Moya

enum RiotQuery {
  case findSummonerByName(name: String)
  case findRankByID(id: String)
}

extension RiotQuery: TargetType {
  var baseURL: URL { URL(string: Constraints.RIOT_BASE_URL)! }
  
  var path: String {
    switch self {
    case .findSummonerByName(name: let name): return "/lol/summoner/v4/summoners/by-name/\(name)"
    case .findRankByID(id: let id): return "/lol/league/v4/entries/by-summoner/\(id)"
    }
  }
  
  var method: Moya.Method {
    .get
  }
  
  var task: Moya.Task {
    return .requestParameters(parameters: ["api_key": Constraints.RIOT_API_KEY], encoding: URLEncoding.queryString)
  }
  
  var headers: [String : String]? {
    [:]
  }
  
  var sampleData: Data {
    switch self {
    case .findSummonerByName:
      return """
{
    "id": "AAAA0aaaAAAaaAa0a0aaaaaAaAaya0aAAaa0aa0aaaa0a",
    "accountId": "AAAA0aaaAAAaaAa0a0aaaaaAaAaya0aAAaa0aa0aaaa0a",
    "puuid": "AAAA0aaaAAAaaAa0a0aaaaaAaAaya0aAAaa0aa0aaaa0aAAAA0aaaAAAaaAa0a0aaaaaAaAaya0aAAaa0aa0aaaa0a",
    "name": "건전한 소환사",
    "profileIconId": 984,
    "revisionDate": 12342532016000,
    "summonerLevel": 199
}
"""
        .data(using: .utf8)!
      
    case .findRankByID:
      return """
[
    {
        "leagueId": "00bd0000-0b00-0efb-a00f-dcc000d0faf0",
        "queueType": "RANKED_SOLO_5x5",
        "tier": "MASTER",
        "rank": "I",
        "summonerId": "AAAA0aaaAAAaaAa0a0aaaaaAaAaya0aAAaa0aa0aaaa0a",
        "summonerName": "건전한 소환사",
        "leaguePoints": 81,
        "wins": 10,
        "losses": 9,
        "veteran": false,
        "inactive": false,
        "freshBlood": false,
        "hotStreak": false
    },
    {
        "queueType": "RANKED_TFT_PAIRS",
        "summonerId": "AAAA0aaaAAAaaAa0a0aaaaaAaAaya0aAAaa0aa0aaaa0a",
        "summonerName": "건전한 소환사",
        "leaguePoints": 0,
        "wins": 16,
        "losses": 62,
        "veteran": false,
        "inactive": false,
        "freshBlood": false,
        "hotStreak": false
    }
]
"""
        .data(using: .utf8)!
      
    }
  }
}
