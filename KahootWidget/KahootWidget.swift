//
//  KahootWidget.swift
//  KahootWidget
//
//  Created by Frank Bara on 10/2/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct KahootWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            GeometryReader { geometryProxy in
                Image("DummyImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometryProxy.size.width, height: geometryProxy.size.height)
                    .clipped()
                    .overlay(
                        Text("6 Qs")
                            .font(.custom("Montserrat", size: 12, relativeTo: .title))
                            .bold()
                            .foregroundColor(.white)
                            .padding(4)
                            .background(Color("NumberOfQsBackground"))
                            .cornerRadius(4)
                            .padding(8)
                        , alignment: .bottomTrailing
                    )
            }
            VStack(alignment: .leading) {
                Text("TOP PICKS")
                    .font(.custom("Montserrat", size: 11, relativeTo: .title))
                    .foregroundColor(Color("Gray4"))
                    .bold()
                    .lineLimit(1)
                Text("World architecture")
                    .font(.custom("Montserrat", size: 12, relativeTo: .body))
                    .foregroundColor(Color("Gray5"))
                    .bold()
                    .lineLimit(2)
            }.padding(EdgeInsets(top: 4, leading: 16, bottom: 16, trailing: 16))
        }.background(Color("SmallWidgetBackground"))
    }
}

@main
struct KahootWidget: Widget {
    let kind: String = "KahootWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            KahootWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct KahootWidget_Previews: PreviewProvider {
    static var previews: some View {
        
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            KahootWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                        .previewContext(WidgetPreviewContext(family: .systemSmall))
                .environment(\.colorScheme, colorScheme)
        }
        
    }
}
