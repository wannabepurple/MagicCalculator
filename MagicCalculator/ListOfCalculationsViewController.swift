import UIKit

class ListOfCalculationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: Other logic
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
