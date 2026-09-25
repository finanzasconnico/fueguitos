import AppIntents
import SwiftUI
import WidgetKit

// MARK: - Acción del botón: anotar o desanotar sin abrir la app

struct ToggleHabitIntent: AppIntent {
    static var title: LocalizedStringResource = "Anotar hábito"
    static var description = IntentDescription("Anota o desanota un hábito de hoy en Fueguitos.")

    @Parameter(title: "Hábito") var habitId: String

    init() {}
    init(habitId: String) { self.habitId = habitId }

    func perform() async throws -> some IntentResult {
        try await Shared.toggle(habitId: habitId)
        return .result()
    }
}

// MARK: - Datos

struct FuegoEntry: TimelineEntry {
    let date: Date
    let habits: [Habit]
    let loggedIn: Bool
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> FuegoEntry {
        FuegoEntry(date: .now, habits: [
            Habit(["id": "1", "name": "Deporte", "emoji": "💪", "streak": 12, "required_today": true, "done_today": true]),
            Habit(["id": "2", "name": "Lectura", "emoji": "📚", "streak": 5, "required_today": true, "done_today": false]),
        ], loggedIn: true)
    }

    func getSnapshot(in context: Context, completion: @escaping (FuegoEntry) -> Void) {
        let cached = Shared.cachedHabits
        completion(cached.isEmpty ? placeholder(in: context) : FuegoEntry(date: .now, habits: cached, loggedIn: Shared.token != nil))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<FuegoEntry>) -> Void) {
        Task {
            let logged = Shared.token != nil
            let list = (try? await Shared.habits()) ?? Shared.cachedHabits
            let entry = FuegoEntry(date: .now, habits: list, loggedIn: logged)
            // Se refresca seguido: el día cierra a las 5 AM y los amigos anotan a cualquier hora.
            completion(Timeline(entries: [entry], policy: .after(.now.addingTimeInterval(15 * 60))))
        }
    }
}

// MARK: - Vista

private let fire = Color(red: 1, green: 0.353, blue: 0.122)
private let gold = Color(red: 1, green: 0.722, blue: 0)
private let okGreen = Color(red: 0.169, green: 0.761, blue: 0.451)
private let dim = Color(red: 0.557, green: 0.478, blue: 0.439)

struct FuegoView: View {
    @Environment(\.widgetFamily) var family
    let entry: FuegoEntry

    var body: some View {
        if !entry.loggedIn {
            VStack(alignment: .leading, spacing: 6) {
                Text("🔥 Fueguitos").font(.headline).foregroundStyle(gold)
                Text("Abrí la app y entrá con tu apodo para ver tu racha acá.").font(.caption).foregroundStyle(.white.opacity(0.8))
            }
        } else {
            let pending = entry.habits.filter { $0.required && !$0.done }
            let max = family == .systemSmall ? 3 : 4
            VStack(alignment: .leading, spacing: family == .systemSmall ? 4 : 6) {
                Text(pending.isEmpty ? "🔥 Día completo" : "🔥 Te falta hoy")
                    .font(.system(size: 13, weight: .heavy))
                    .foregroundStyle(pending.isEmpty ? gold : fire)
                if entry.habits.isEmpty {
                    Text("Activá tus hábitos en la app.").font(.caption).foregroundStyle(.white.opacity(0.8))
                }
                ForEach(entry.habits.prefix(max)) { h in
                    Button(intent: ToggleHabitIntent(habitId: h.id)) {
                        HStack(spacing: 8) {
                            ZStack {
                                Circle().fill(h.done ? okGreen : Color.white.opacity(0.08))
                                Circle().strokeBorder(h.done ? okGreen : (h.required ? fire : dim), lineWidth: 2)
                                if h.done { Image(systemName: "checkmark").font(.system(size: 12, weight: .black)).foregroundStyle(.white) }
                            }
                            .frame(width: 22, height: 22)
                            Text("\(h.emoji) \(h.streak)")
                                .font(.system(size: family == .systemSmall ? 17 : 19, weight: .heavy))
                                .foregroundStyle(h.done ? gold : .white)
                            if family != .systemSmall {
                                Text(h.name).font(.system(size: 13, weight: .semibold)).foregroundStyle(.white.opacity(0.75)).lineLimit(1)
                                Spacer(minLength: 4)
                                Text("🧊\(h.ice) ⌛\(h.left)").font(.system(size: 12)).foregroundStyle(.white.opacity(0.6))
                            }
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct FueguitosWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "FueguitosWidget", provider: Provider()) { entry in
            FuegoView(entry: entry)
                .containerBackground(for: .widget) {
                    LinearGradient(colors: [Color(red: 0.165, green: 0.078, blue: 0.047), Color(red: 0.09, green: 0.055, blue: 0.043)],
                                   startPoint: .top, endPoint: .bottom)
                }
                .widgetURL(URL(string: "fueguitos://abrir"))
        }
        .configurationDisplayName("Fueguitos")
        .description("Tu racha a la vista. Tocá un hábito para anotarlo; tocalo de nuevo si fue sin querer.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

@main
struct FueguitosWidgets: WidgetBundle {
    var body: some Widget { FueguitosWidget() }
}
