import Capacitor
import HealthKit
import UIKit
import UserNotifications
import WidgetKit

/// Puente entre la web (index.html) y lo nativo: sesión para el widget, avisos y la app Salud.
/// Desde JS: Capacitor.nativePromise('Fueguitos', '<método>', {...})
@objc(FueguitosPlugin)
public class FueguitosPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "FueguitosPlugin"
    public let jsName = "Fueguitos"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "setSession", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "clearSession", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "reloadWidget", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "pushStatus", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "registerPush", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "healthAvailable", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "healthAuthorize", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "healthSince", returnType: CAPPluginReturnPromise),
    ]

    private let health = HKHealthStore()
    private var pushCall: CAPPluginCall?

    override public func load() {
        NotificationCenter.default.addObserver(self, selector: #selector(onPushToken(_:)), name: .fueguitosPushToken, object: nil)
    }

    // MARK: Sesión y widget

    @objc func setSession(_ call: CAPPluginCall) {
        guard let token = call.getString("token"), let api = call.getString("api"), let key = call.getString("key") else {
            call.reject("Faltan datos"); return
        }
        Shared.saveSession(token: token, api: api, key: key, app: call.getString("app") ?? Shared.appURL)
        if let hs = call.getArray("habits") as? [[String: Any]] { Shared.cache(hs.map(Habit.init)) }
        WidgetCenter.shared.reloadAllTimelines()
        call.resolve()
    }

    @objc func clearSession(_ call: CAPPluginCall) {
        Shared.clearSession()
        WidgetCenter.shared.reloadAllTimelines()
        call.resolve()
    }

    @objc func reloadWidget(_ call: CAPPluginCall) {
        if let hs = call.getArray("habits") as? [[String: Any]] { Shared.cache(hs.map(Habit.init)) }
        WidgetCenter.shared.reloadAllTimelines()
        call.resolve()
    }

    // MARK: Avisos (APNs)

    @objc func pushStatus(_ call: CAPPluginCall) {
        UNUserNotificationCenter.current().getNotificationSettings { s in
            let st: String
            switch s.authorizationStatus {
            case .authorized, .provisional, .ephemeral: st = "granted"
            case .denied: st = "denied"
            default: st = "default"
            }
            call.resolve(["status": st])
        }
    }

    @objc func registerPush(_ call: CAPPluginCall) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            guard granted else { call.resolve(["granted": false]); return }
            DispatchQueue.main.async {
                self.pushCall = call
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    @objc private func onPushToken(_ n: Notification) {
        guard let call = pushCall else { return }
        pushCall = nil
        if let token = n.object as? String { call.resolve(["granted": true, "token": token]) }
        else { call.reject((n.object as? Error)?.localizedDescription ?? "No se pudo registrar el celu para avisos") }
    }

    // MARK: Salud

    @objc func healthAvailable(_ call: CAPPluginCall) {
        call.resolve(["available": HKHealthStore.isHealthDataAvailable()])
    }

    @objc func healthAuthorize(_ call: CAPPluginCall) {
        guard HKHealthStore.isHealthDataAvailable() else { call.resolve(["ok": false]); return }
        let read: Set<HKObjectType> = [HKObjectType.workoutType(), HKCategoryType(.mindfulSession)]
        health.requestAuthorization(toShare: nil, read: read) { ok, _ in call.resolve(["ok": ok]) }
    }

    /// Entrenamientos y minutos de meditación desde `since` (ms epoch).
    @objc func healthSince(_ call: CAPPluginCall) {
        guard HKHealthStore.isHealthDataAvailable() else { call.resolve(["workouts": [], "mindful": 0]); return }
        let since = Date(timeIntervalSince1970: (call.getDouble("since") ?? 0) / 1000)
        let pred = HKQuery.predicateForSamples(withStart: since, end: nil)
        let sort = [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)]
        let group = DispatchGroup()
        var workouts: [[String: Any]] = []
        var mindful = 0.0

        group.enter()
        health.execute(HKSampleQuery(sampleType: .workoutType(), predicate: pred, limit: 50, sortDescriptors: sort) { _, samples, _ in
            for w in (samples as? [HKWorkout]) ?? [] {
                workouts.append(["type": Self.workoutName(w.workoutActivityType), "minutes": Int(w.duration / 60),
                                 "start": w.startDate.timeIntervalSince1970 * 1000])
            }
            group.leave()
        })
        group.enter()
        health.execute(HKSampleQuery(sampleType: HKCategoryType(.mindfulSession), predicate: pred, limit: 100, sortDescriptors: sort) { _, samples, _ in
            for s in samples ?? [] { mindful += s.endDate.timeIntervalSince(s.startDate) / 60 }
            group.leave()
        })
        group.notify(queue: .main) { call.resolve(["workouts": workouts, "mindful": Int(mindful)]) }
    }

    private static func workoutName(_ t: HKWorkoutActivityType) -> String {
        switch t {
        case .running: return "Correr"
        case .walking: return "Caminata"
        case .cycling: return "Bici"
        case .swimming: return "Natación"
        case .traditionalStrengthTraining, .functionalStrengthTraining: return "Gimnasio"
        case .highIntensityIntervalTraining: return "HIIT"
        case .yoga: return "Yoga"
        case .soccer: return "Fútbol"
        case .basketball: return "Básquet"
        case .tennis, .paddleSports, .racquetball: return "Tenis/pádel"
        case .crossTraining: return "Cross"
        case .dance: return "Baile"
        case .elliptical: return "Elíptica"
        case .rowing: return "Remo"
        case .hiking: return "Trekking"
        default: return "Entrenamiento"
        }
    }
}
