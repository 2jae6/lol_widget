//
//  Provider.swift
//  LoLWidgetExtensionExtension
//
//  Created by JK on 2022/02/16.
//

import Combine
import WidgetKit

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry(configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        let entry: WidgetEntry
        if context.isPreview {
            let league = League(summonerName: "2jae6", queue: .rankSolo, tier: League.Tier(tier: .challenger, rank: nil), points: 2000, wins: 20, losses: 0)
            entry = WidgetEntry(configuration: configuration, league: league, lastUpdated: Date())
        } else {
            entry = WidgetEntry(configuration: configuration)
        }
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {

        @Sendable
        func emptyTimeline() {
            let currentDate = Date()
            let refreshData = Calendar.current.date(byAdding: .minute, value: 10, to: currentDate)! // 10분 뒤 업데이트
            let timeline = Timeline(entries: [WidgetEntry(configuration: configuration)], policy: .after(refreshData))
            completion(timeline)
        }

        guard let username = configuration.username?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            emptyTimeline()
            return
        }

        Task {
            guard
                let _id = try? await RiotService.summonerIDBy(name: username).get(),
                let _rank = try? await RiotService.leagueBy(id: _id).get(),
                let _league = _rank.first(where: { $0.queueType == "RANKED_SOLO_5x5" }),
                let league = League.from(dto: _league) else
            {
                emptyTimeline()
                return
            }

            let refreshDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!

            let timeline = Timeline(entries: [WidgetEntry(configuration: configuration, league: league)], policy: .after(refreshDate))
            completion(timeline)

        }
    }
}
