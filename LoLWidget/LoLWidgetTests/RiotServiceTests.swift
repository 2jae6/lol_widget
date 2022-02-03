//
//  RiotServiceTests.swift
//  LoLWidgetTests
//
//  Created by JK on 2022/01/30.
//

import XCTest
@testable import LoLWidget

class RiotServiceTests: XCTestCase {

    func testGetId() async throws {
        let _ = try await RiotService.summonerIDBy(name: "폰쿠료무").get()
    }

    func testGetRank() async throws {
        let id = try await RiotService.summonerIDBy(name: "폰쿠료무").get()
        let _ = try await RiotService.leagueBy(id: id).get()
    }

}
