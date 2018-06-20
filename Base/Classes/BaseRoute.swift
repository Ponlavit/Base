
import Foundation

let YES : Bool = true
let NO : Bool = false

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

public class RouteManager {
    public static var navigation : RouteManager!
    private var rootNavigation : UINavigationController!
    public static func setup(withRoot:UINavigationController) {
        if(RouteManager.navigation == nil) {
            RouteManager.navigation = RouteManager()
            RouteManager.navigation.rootNavigation = withRoot
        }
    }
    
    public func isShowingScreen(_ screen:BaseScreen) -> Bool{
        let currentScreen =
            NSStringFromClass((rootNavigation.visibleViewController?.classForCoder)!).components(separatedBy: ".").last!
        let screenToCheck = "\(screen.screenName)ViewController"
        return currentScreen.elementsEqual(screenToCheck)
    }
    
    public func to(_ screen:BaseScreen!,method:ScreenTransitionMethod, animated:Bool?) {
        self.routeTo(screen,method:method,animated:animated)
    }
    
    public func pop(animated: Bool){
        self.rootNavigation.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool){
        self.rootNavigation.popToRootViewController(animated: animated)
    }
    
    
    public func to(_ viewContrller:BaseViewController,method:ScreenTransitionMethod, animated:Bool?){
        switch method {
        case .push:
            self.rootNavigation.pushViewController(viewContrller, animated: animated!)
        case .replace:
            let cv = viewContrller
            self.rootNavigation.viewControllers.insert(cv, at: 0)
            self.rootNavigation.popToRootViewController(animated: animated!)
        case .pushWith(let obj):
            let cv = viewContrller
            cv.presenter.presenterModel = obj
            self.rootNavigation.pushViewController(cv, animated: animated!)
        case .replaceWith(let obj):
            let cv = viewContrller
            cv.presenter.presenterModel = obj
            self.rootNavigation.viewControllers.insert(cv, at: 0)
            self.rootNavigation.popToRootViewController(animated: animated!)
        }
    }
    
    public func routeTo(_ screen:BaseScreen!,method:ScreenTransitionMethod, animated:Bool?) {
        self.to(Base.build(screen), method: method, animated: animated)
    }
}

public protocol BaseScreen {
    var screenName: String {get}
    var screenTitle: String {get}
}

public enum ScreenTransitionMethod {
    case push
    case replace
    case pushWith(Any)
    case replaceWith(Any)
}
