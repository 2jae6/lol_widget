//
//  LoLWidgetExtension.swift
//  LoLWidgetExtension
//
//  Created by Jay on 2022/01/30.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct LoLWidgetExtensionEntryView : View {
    var entry: Provider.Entry
// 뷰 생성
    
    var body: some View {
        HStack(alignment: .center, spacing: 50){
            Image("silver")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 100, height: 100)
                
           
            VStack{
                Text("닉네임").foregroundColor(.orange)
                
                Text("티어 및 점수").foregroundColor(.orange)
                
                Text("총전적/승/패/승률").foregroundColor(.orange)
                
                Text("최근 업데이트 시간").foregroundColor(.orange)
                
            }
        }
        
    }
}

@main
struct LoLWidgetExtension: Widget {
    let kind: String = "LoLWidgetExtension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LoLWidgetExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("My LoL")
        .description("This is an LoL widget.")
    }
}

struct LoLWidgetExtension_Previews: PreviewProvider {
    static var previews: some View {
        LoLWidgetExtensionEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
