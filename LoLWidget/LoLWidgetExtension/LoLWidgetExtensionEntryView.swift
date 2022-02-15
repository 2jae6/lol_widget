//
//  LoLWidgetExtensionEntryView.swift
//  LoLWidget
//
//  Created by JK on 2022/02/16.
//

import SwiftUI

struct LoLWidgetExtensionEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        if let league = entry.league {
            HStack {
                if let tier = league.tier {
                    Image("\(tier.tier.rawValue)_emblem")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(.trailing, 10)
                }

                VStack(alignment: .leading) {
                    Text(league.summonerName)
                        .font(.title2)
                        .fontWeight(.heavy)
                        .padding(.bottom, 10)
                    if let tier = league.tier {
                        HStack {
                            Text("랭크")
                                .fontWeight(.medium)
                            if let num = tier.rank {
                                Text("\(tier.tier.rawValue) \(num)")
                                    .font(.subheadline)
                            } else {
                                Text(tier.tier.rawValue)
                                    .font(.subheadline)
                            }
                        }
                    }

                    HStack {
                        Text("승률")
                            .fontWeight(.medium)
                        Text("\(league.wins)승 \(league.losses)패 \(String(format: "%.2f", league.winRate * 100))%")
                            .font(.subheadline)
                    }

                    Text("업데이트 시각: \(entry.lastUpdatedFormatted)")
                        .font(.caption2)
                        .fontWeight(.thin)
                        .padding(.top)
                }
            }
        } else {
            Text("소환사 이름을 입력해 주세요")
        }
    }
}
