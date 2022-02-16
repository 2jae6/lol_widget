//
//  WidgetEntry.swift
//  LoLWidget
//
//  Created by JK on 2022/02/16.
//

import Foundation
import WidgetKit

struct WidgetEntry: TimelineEntry {
    var date: Date {
        Date()
    }

    let league: League?
    let lastUpdated: Date
    var lastUpdatedFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:MM"
        return formatter.string(from: lastUpdated)
    }

    init(configuration: ConfigurationIntent, league: League? = nil, lastUpdated: Date = Date()) {
        self.league = league
        self.lastUpdated = lastUpdated
        self.configuration = configuration
    }

    let configuration: ConfigurationIntent
}
