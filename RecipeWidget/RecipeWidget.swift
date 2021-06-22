//
//  RecipeWidget.swift
//  RecipeWidget
//
//  Created by 李承紘 on 2021/6/22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), recommendation: RecommendProvider.random())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), recommendation: RecommendProvider.random())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
//        let calendar = Calendar.autoupdatingCurrent
//        let hour = calendar.component(.hour, from: currentDate)
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: Date(), recommendation: RecommendProvider.random())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let recommendation: String
}

struct RecipeWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color(UIColor.systemOrange)
          VStack {
            Text("😋")
              .font(.system(size: 56))
            Text("Today's Recommendation")
              .font(.system(size: 20))
            Text(entry.recommendation)
              .font(.headline)
              .multilineTextAlignment(.center)
              .padding(.top, 5)
              .padding([.leading, .trailing])
              .foregroundColor(.white)
          }
        }
        
    }
}

@main
struct RecipeWidget: Widget {
    let kind: String = "RecipeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RecipeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Recipe recommendation")
        .description("This is the widget for recommendation.")
        .supportedFamilies([.systemMedium])
    }
}

struct RecipeWidget_Previews: PreviewProvider {
    static var previews: some View {
        RecipeWidgetEntryView(entry: SimpleEntry(date: Date(), recommendation: "test"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
