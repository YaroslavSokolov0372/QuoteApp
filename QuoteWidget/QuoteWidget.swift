//
//  QuoteWidget.swift
//  QuoteWidget
//
//  Created by Yaroslav Sokolov on 29/09/2023.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    @MainActor func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), randomQuote: fetchCollections())
    }
    
    @MainActor func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), randomQuote: fetchCollections())
        completion(entry)
    }
    
    @MainActor func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {        
        Task {

            let quotesCollections: Quote? = fetchCollections()
            let components = DateComponents(minute: 60)
            let nextUpdate = Calendar.current.date(byAdding: components , to: Date())!
            
            let timeline = Timeline(entries: [SimpleEntry(date: Date(), randomQuote: quotesCollections)], policy: .after(nextUpdate))
            print(nextUpdate)
            completion(timeline)
        }
    }
}

@MainActor
func fetchCollections() -> Quote? {
    
    guard let modelContainer = try? ModelContainer(for: QuoteCollection.self) else { return nil }
    
    let quoteCollections = try? modelContainer.mainContext.fetch(FetchDescriptor<QuoteCollection>())
    
    var randomQuote: Quote? = nil
    
    if let collections = quoteCollections {
        if !collections.isEmpty {
            let randomCollection = collections.randomElement()
            randomQuote = randomCollection?.quotes.randomElement()
        }
    }
    
    
    return randomQuote ?? nil
    
    
}



struct SimpleEntry: TimelineEntry {
    let date: Date
    let randomQuote: Quote?
}

@MainActor struct QuoteWidgetEntryView : View {
    
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry
    var randomRectangle = customRectanglesArray.randomElement()!
    
    
    var body: some View {
        VStack {
            if entry.randomQuote != nil {
                GeometryReader { geo in
                    ZStack {
                        Rectangle()
                            .fill(randomRectangle.color)
                            .frame(width: 300, height: 300)
                            .offset(x: -55, y: -40)
                            .rotationEffect(.degrees(-33), anchor: .topTrailing)
                        
                        
                        VStack {
                            Text(entry.randomQuote!.quote)
                                .textCase(.uppercase)
                                .customFont(16, .mono)
                                .multilineTextAlignment(.center)
                                .frame(width: 300, height: 90, alignment: .top)
                            
                            HStack {
                                
                                Spacer()
                                
                                Text(entry.randomQuote!.whomQuote)
                                    .foregroundColor(.black.opacity(0.5))
                                    .customFont(10, .mono)
                                    .padding(.trailing, 10)
                                    .offset(y: 10)
                            }
                            
                        }
                        .padding(.top, 10)
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
                
            } else {
                VStack {
                    Text("There is no any Quote yet")
                        .customFont(16, .mono)
                }
            }
            
        }
    }
}

struct QuoteWidget: Widget {
    let kind: String = "QuoteWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            QuoteWidgetEntryView(entry: entry)
                .containerBackground(.white, for: .widget)
        }
        .configurationDisplayName("Quote Widget")
        .description("See quotes on the main screen")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemSmall) {
    QuoteWidget()
} timeline: {
    SimpleEntry(date: .now, randomQuote: nil)
    SimpleEntry(date: .now, randomQuote: nil)
}
