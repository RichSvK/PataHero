import AppIntents
import SwiftUI
import WidgetKit

struct CallEkaHospitalIntent: AppIntent {
    static var title: LocalizedStringResource = "Hubungi Eka Hospital"
    static var openAppWhenRun: Bool = false
    
    func perform() async throws -> some IntentResult {
        let phone = "tel://081231506069"
        guard let url = URL(string: phone) else {
            throw NSError(domain: "InvalidURL", code: 0)
        }
        
        // For widgets, we return the URL and let the system handle it
        return .result(value: url)
    }
}

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let entries = [SimpleEntry(date: Date(), configuration: configuration)]
        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct PataheroWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.openURL) private var openURL

    var body: some View {
        HStack{
            Image(systemName: "plus.rectangle")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.red)
            
            Text("Eka Hospital")
                .font(.system(size: 20, weight: .semibold))
        }
            
        HStack(spacing: 10) {
            if let callUrl = URL(string: "Patahero://call"){
                Link(destination: callUrl){
                    HStack{
                        Spacer()
                        Image(systemName: "phone.fill")
                        
                        Text("Hubungi")
                            .font(.system(size: 14))
                        Spacer()
                    }
                    .padding(15)
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }

            if let navigateUrl = URL(string: "Patahero://hospital"){
                Link(destination: navigateUrl){
                    HStack{
                        Spacer()
                        Image(systemName: "map.fill")
                        Text("Navigasi")
                            .font(.system(size: 14))
                        Spacer()
                    }
                    .padding(15)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
        .padding(10)
    }
}

struct PataheroWidget: Widget {
    let kind: String = "PataheroWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self,
            provider: Provider()
        ) { entry in
            PataheroWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Patahero Widget")
        .description("Widget untuk menghubungi Eka Hospital")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    PataheroWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: ConfigurationAppIntent())
}
