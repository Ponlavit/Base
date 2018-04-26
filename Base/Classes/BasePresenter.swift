
import Foundation

/// Presenter will be acting like a bridge between, View, ViewModel and Model. This will take care of getting data from Model and pass it to View through View model. ViewModel will have only the properties which are used to Bind data to View and hold data that comes from View. Presenter will have other implementations to talk to business layer and get domain model and update view model to pass the information to View.
open class BasePresenter {
    
    /*! @brief as view action to continue perform route action */
    private let route:BaseRoute!
    /*! @brief update back to view if need (suggestion using Rx) */
    weak var view:BaseViewController!
    
    public required init(route:BaseRoute, viewController: BaseViewController){
        self.route = route
        self.view = viewController
    }
    
    /*! @brief do some initial for view */
    open func viewIsReady(){
        
    }
    
    public func getRoute() -> BaseRoute {
        return self.route
    }
    
    public func getView() -> BaseViewController {
        return self.view
    }
    
    /*! @brief do some release or remove data for view */
    open func viewIsGone() {
        
    }
}
