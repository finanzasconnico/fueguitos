import Foundation

/// Lo que comparten la app y el widget: la sesión (guardada en el App Group) y las llamadas a Supabase.
enum Shared {
    static let appGroup = "group.com.nicostrijland.fueguitos"
    static var defaults: UserDefaults { UserDefaults(suiteName: appGroup) ?? .standard }

    static var token: String? { defaults.string(forKey: "token") }
    static var apiURL: String? { defaults.string(forKey: "api") }
    static var apiKey: String? { defaults.string(forKey: "key") }
    static var appURL: String { defaults.string(forKey: "app") ?? "https://fueguitos.vercel.app/" }

    static func saveSession(token: String, api: String, key: String, app: String) {
        let d = defaults
        d.set(token, forKey: "token")
        d.set(api, forKey: "api")
        d.set(key, forKey: "key")
        d.set(app, forKey: "app")
    }

    static func clearSession() {
        ["token", "habits"].forEach { defaults.removeObject(forKey: $0) }
    }

    enum ApiError: Error { case sinSesion, servidor(String) }

    /// Llama a una función RPC `api_*` de Supabase con la llave del usuario.
    static func rpc(_ fn: String, _ body: [String: Any] = [:]) async throws -> Any {
        guard let token, let apiURL, let apiKey, let url = URL(string: "\(apiURL)/rest/v1/rpc/\(fn)") else { throw ApiError.sinSesion }
        var req = URLRequest(url: url, timeoutInterval: 15)
        req.httpMethod = "POST"
        req.setValue(apiKey, forHTTPHeaderField: "apikey")
        req.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        var payload = body
        payload["p_token"] = token
        req.httpBody = try JSONSerialization.data(withJSONObject: payload)
        let (data, resp) = try await URLSession.shared.data(for: req)
        let status = (resp as? HTTPURLResponse)?.statusCode ?? 0
        let json = data.isEmpty ? NSNull() : try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
        if !(200..<300).contains(status) {
            throw ApiError.servidor((json as? [String: Any])?["message"] as? String ?? "HTTP \(status)")
        }
        return json
    }

    /// Hábitos activos del usuario (mismo formato que `_habit_json`).
    static func habits() async throws -> [Habit] {
        let me = try await rpc("api_me") as? [String: Any]
        let list = (me?["habits"] as? [[String: Any]] ?? []).map(Habit.init)
        cache(list)
        return list
    }

    static func cache(_ list: [Habit]) {
        if let data = try? JSONEncoder().encode(list) { defaults.set(data, forKey: "habits") }
    }

    static var cachedHabits: [Habit] {
        guard let data = defaults.data(forKey: "habits"), let list = try? JSONDecoder().decode([Habit].self, from: data) else { return [] }
        return list
    }

    /// Anota el hábito si no está hecho hoy; si ya estaba, lo desanota. Devuelve la lista actualizada.
    @discardableResult
    static func toggle(habitId: String) async throws -> [Habit] {
        let current = cachedHabits.first { $0.id == habitId }
        if current?.done == true {
            let hs = try await rpc("api_undo_checkin", ["p_habit": habitId]) as? [[String: Any]] ?? []
            let list = hs.map(Habit.init); cache(list); return list
        } else {
            let r = try await rpc("api_checkin", ["p_habits": [habitId], "p_photo": NSNull(), "p_note": NSNull()]) as? [String: Any]
            let list = (r?["habits"] as? [[String: Any]] ?? []).map(Habit.init); cache(list); return list
        }
    }
}

struct Habit: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let emoji: String
    let streak: Int
    let ice: Int
    let left: Int
    let required: Bool
    let done: Bool

    init(_ d: [String: Any]) {
        id = d["id"] as? String ?? ""
        name = d["name"] as? String ?? ""
        emoji = d["emoji"] as? String ?? "🔥"
        streak = d["streak"] as? Int ?? 0
        ice = d["ice"] as? Int ?? 0
        left = d["left_for_ice"] as? Int ?? 0
        required = d["required_today"] as? Bool ?? false
        done = d["done_today"] as? Bool ?? false
    }
}
