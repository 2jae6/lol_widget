//
//  RiotService.swift
//  LoLWidget
//
//  Created by JK on 2022/01/30.
//

import Foundation
import Moya

/// Riot API 사용을 위한 Service
final class RiotService {

    static func summonerIDBy(name: String) async -> Result<String, RiotServiceError> {
        let data: Data
        switch await requestData(query: .findSummonerByName(name: name)) {
        case .success(let _data):
            data = _data
        case .failure(let err):
            if case .statusCode(let e) = err, e.statusCode == 404 {
                return .failure(.userNotFound)
            } else {
                return .failure(.requestFailed)
            }
        }

        let summoner: SummonerDTO
        do {
            summoner = try JSONDecoder().decode(SummonerDTO.self, from: data)
        } catch {
            return .failure(.decodingError)
        }

        return .success(summoner.id)
    }

    static func leagueBy(id: String) async -> Result<[LeagueEntryDTO], RiotServiceError> {
        let data: Data
        switch await requestData(query: .findRankByID(id: id)) {
        case .success(let _data):
            data = _data
        case .failure(let err):
            if case .statusCode(let e) = err, e.statusCode == 404 {
                return .failure(.userNotFound)
            } else {
                return .failure(.requestFailed)
            }
        }

        let league: [LeagueEntryDTO]
        do {
            league = try JSONDecoder().decode([LeagueEntryDTO].self, from: data)
        } catch {
            return .failure(.decodingError)
        }

        return .success(league)
    }

    private static func requestData(query: RiotQuery) async -> Result<Data, MoyaError> {
        await withUnsafeContinuation { continuation in
            let provier = MoyaProvider<RiotQuery>()
            provier.request(query) { result in
                switch result {
                case .failure(let err):
                    continuation.resume(returning: .failure(err))
                case .success(let response):
                    if response.statusCode != 200 {
                        continuation.resume(returning: .failure(.statusCode(response)))
                    } else {
                        continuation.resume(returning: .success(response.data))
                    }
                }
            }
        }
    }
}

enum RiotServiceError: Error {
    case requestFailed
    case decodingError
    case urlError
    case userNotFound
}
