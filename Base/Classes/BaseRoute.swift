
import Foundation


/// Contain the navigation option and action
open class BaseRoute {
    
    /*! @brief use to perform segue and navigation action */
    private weak var viewController:BaseViewController!
    
    public required init(viewController:BaseViewController) {
        self.viewController = viewController
    }
}
