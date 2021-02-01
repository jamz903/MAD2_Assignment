//
//  TOMSwidget.swift
//  TOMSwidget
//
//  Created by Shane-Rhys Chua on 1/2/21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), uri: "")
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, uri: "")
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            
            //let uri = char?.objectID.uriRepresentation().absoluteString;
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, uri: "")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let uri: String?
    
    var url : URL?{
        get{
            if let linkID = self.uri{
                return URL(string: "ConnectMAD2://" + linkID)
            }
            return nil
        }
    }
}

//let TOMSwidgetEntry = SimpleEntry(date: Date(), configuration: ConfigurationIntent, uri: nil)

struct TOMSwidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        
                    ZStack {
                        Color.blue
                            .ignoresSafeArea()
                        Text(" TOMS").fontWeight(.heavy).foregroundColor(.white).multilineTextAlignment(.center).font(.title).padding(3)

                    }

    }
}



@main
struct TOMSwidget: Widget {
    let kind: String = "TOMSwidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            TOMSwidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct TOMSwidget_Previews: PreviewProvider {
    static var previews: some View {
        TOMSwidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), uri: ""))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
