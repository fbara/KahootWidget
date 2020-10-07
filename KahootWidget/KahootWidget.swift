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
    func placeholder(in context: Context) -> WidgetTimelineEntry {
        // The placeholder will show while data is loading, so the text will be redacted. That means we don’t have to provide any meaningful data.
        let discoverGroup = DiscoverGroup(cardTitle: "------------", coverImage: Image("DummyImage"), creatorAvatarImage: nil, creatorUsername: "-------", groupTitle: "----------", numberOfQuestions: 10)
    
        return WidgetTimelineEntry(date: Date(), configuration: ConfigurationIntent(), discoverGroup: discoverGroup)
    
        // original last line.
        //WidgetTimelineEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WidgetTimelineEntry) -> ()) {
        // This function needs to return a timeline object that will be displayed in the widget gallery, so here we should provide valid dummy data.
        let discoverGroup = DiscoverGroup(cardTitle: "World Architecture", coverImage: Image("DummyImage"), creatorAvatarImage: nil, creatorUsername: "Frank B.", groupTitle: "TOP PICKS", numberOfQuestions: 6)
        
        // original code.
        //let entry = WidgetTimelineEntry(date: Date(), configuration: configuration)
        //completion(entry)
        
        let entry = WidgetTimelineEntry(date: Date(), configuration: configuration, discoverGroup: discoverGroup)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        // Needs to return an array of timeline events. For this exercise, let’s return just one element that will refresh after an hour.
        let discoverGroup = DiscoverGroup(cardTitle: "World Architecture", coverImage: Image("DummyImage"), creatorAvatarImage: nil, creatorUsername: "Frank B.", groupTitle: "TOP PICKS", numberOfQuestions: 6)
        
        let entry = WidgetTimelineEntry(date: Date(), configuration: ConfigurationIntent(), discoverGroup: discoverGroup)
        let date = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
        let timeline = Timeline(entries: [entry], policy: TimelineReloadPolicy.after(date))
        
        //var entries: [WidgetTimelineEntry] = []

//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = WidgetTimelineEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetTimelineEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let discoverGroup: DiscoverGroup
}

struct KahootWidgetEntryView : View {
    @Environment(\.widgetFamily) private var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SmallWidgetView(discoverGroup: entry.discoverGroup)
        case .systemMedium:
            MediumWidgetView(discoverGroup: entry.discoverGroup)
        @unknown default:
            fatalError()
        }
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
            KahootWidgetEntryView(entry: WidgetTimelineEntry(date: Date(), configuration: ConfigurationIntent()))
                        .previewContext(WidgetPreviewContext(family: .systemSmall))
                .environment(\.colorScheme, colorScheme)
        }
        
    }
}
