import UIKit

class ListOfCalculationsViewController: UIViewController {

    var result: String = "No data"
    @IBOutlet weak var lastCalculation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastCalculation.text = result
    }
    
    // MARK: Other logic
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
