//
//  LoLWidgetExtension.swift
//  LoLWidgetExtension
//
//  Created by JK on 2022/02/16.
//

import Intents
import SwiftUI
import WidgetKit

@main
struct LoLWidgetExtension: Widget {
    let kind: String = "LoLWidgetExtension"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            LoLWidgetExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("LoL Widget")
        .description("소환사의 랭크를 보여주는 위젯입니다.")
        .supportedFamilies([.systemMedium])
    }
}

struct LoLWidgetExtension_Previews: PreviewProvider {
    static var previews: some View {
        LoLWidgetExtensionEntryView(entry: WidgetEntry(configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
