
import Foundation


/// Contain the navigation option and action
open class BaseRoute {
    
    /*! @brief use to perform segue and navigation action */
    public private(set) weak var viewController:BaseViewController!
    
    public required init(viewController:BaseViewController) {
        self.viewController = viewController
    }
    
    open func getViewController() -> BaseViewController {
        fatalError("must override to get concrete view controller")
    }
}
