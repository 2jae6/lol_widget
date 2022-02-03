//
//  MainViewModel.swift
//  LoLWidget
//
//  Created by JK on 2022/02/03.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var league: League?
    @Published var text: String = ""

    func searchSummoner() {
        Task(priority: .utility, operation: {
            guard
                let _id = try? await RiotService.summonerIDBy(name: self.text).get(),
                let _rank = try? await RiotService.leagueBy(id: _id).get() else { return }

            let leagues = _rank.map({ League.from(dto: $0) })
            let league = leagues.first(where: { $0?.queue == .rankSolo }) as? League
            setLeague(league)
        })
    }

    func setLeague(_ league: League?) {
        DispatchQueue.main.async {
            self.league = league
        }
    }
}
