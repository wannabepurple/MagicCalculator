import UIKit

enum CalculationError: Error {
    case divideByZero
}

class ViewController: UIViewController {
    
    let maxSymbols = 17
    var calculationHistory: [String] = [] // Number1, operator, Number2
    var result: Double = 0
    var numHistory: [String] = [] // Array of all parts of number
    var equalFlag = 0
    
    // Nums + point symbol
    @IBAction func buttonPressed(_ sender: UIButton) {
        // Next term after operator or after equal symbol
        if numHistory.isEmpty && equalFlag != 1 {
            resetLabelText()
        } else if equalFlag == 1 {
            clearAll()
        }
        
        guard let buttonText = sender.currentTitle else { return }
        
        if buttonText == "." && label.text?.contains(".") == true { return }
        
        // Start to entering the number
        if label.text == "0" && buttonText != "." {
            label.text = ""
        }
        
        if numHistory.count < maxSymbols {
            label.text?.append(buttonText)
            numHistory.append(buttonText)
        }
        
        if buttonText != "." {
            result = numberFormatter.number(from: buildFullNumber())?.doubleValue ?? 0
        }
        
        switch calculationHistory.count {
        case 0, 2: calculationHistory.append(String(result))
        case 1: calculationHistory[0] = String(result)
        case 3: calculationHistory[2] = String(result)
        default: return
        }
        
        func buildFullNumber() -> String {
            var fullNum = ""
            
            for char in numHistory {
                fullNum += char
                
            }
            
            return fullNum
        }
    }
    
    // Operations
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        numHistory = []
        equalFlag = 0
        
        guard let operation = sender.currentTitle else { return }
        
        if calculationHistory.count == 3 {
            calculateAndUpdLabel()
        }
        
        calculationHistory.append(operation)
        
    }
    
    // Equal Button
    @IBAction func calculateButtonPressed() {
        if calculationHistory.count == 3 {
            equalFlag = 1
            calculateAndUpdLabel()
        }
        
    }
    
    // Clear button
    @IBAction func clearButtonPressed() {
        clearAll()
    }
    
    @IBOutlet weak var label: UILabel!
    
    lazy var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.usesGroupingSeparator = false
        numberFormatter.locale = Locale(identifier: "en_EN")
        numberFormatter.numberStyle = .decimal
        
        
        return numberFormatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetLabelText()
    }
    
    func calculate(_ num1: Double, _ operation: String, _ num2: Double) throws -> String {
        switch operation {
        case "+": return String(num1 + num2)
        case "-": return String(num1 - num2)
        case "x": return String(num1 * num2)
        case "/":
            if num2 == 0 {
                throw CalculationError.divideByZero
            }
            return String(num1 / num2)
        default: return "0"
        }
    }
    
    func calculateAndUpdLabel() {
        // Count sum of two terms
        let num1 = Double(calculationHistory[0]) ?? 0
        let num2 = Double(calculationHistory[2]) ?? 0
        
        do {
            let resultString = try calculate(num1, calculationHistory[1], num2)
            if let resultValue = Double(resultString) {
                label.text = (resultValue.truncatingRemainder(dividingBy: 1) == 0) ? String(format: "%.0f", resultValue) : resultString
            }
        } catch {
            label.text = "Error"
        }
        
        
        // Clean numbers and operator storage array
        calculationHistory = []
        
        // Push result and next operator
        calculationHistory.append(label.text ?? "0")
    }
    
    func clearAll() {
        calculationHistory = []
        numHistory = []
        resetLabelText()
        equalFlag = 0
    }
    
    func resetLabelText() {
        label.text = "0"
    }
    
}

