import Foundation

//struct Calculations {
//    let expression: [String]
//}

//extension Calculations: Codable {}

class CalculationHistoryStorage {
    static let calculationHistoryKey = "calculationHistoryKey"
    
    // Запись истории вычислений
    func setHistory(calculations: [String]) {
        if let encoded = try? JSONEncoder().encode(calculations) {
            UserDefaults.standard.set(encoded, forKey: CalculationHistoryStorage.calculationHistoryKey)
        }
    }
    
    // Получение истории вычислений
    func loadHistory() -> [String] {
        if let data = UserDefaults.standard.data(forKey: CalculationHistoryStorage.calculationHistoryKey) {
            return (try? JSONDecoder().decode([String].self, from: data)) ?? []
        }
        return []
    }
}
