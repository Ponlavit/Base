
/// Contain base function to support architecture
public class Base {
    
    public static func build(viewController:BaseViewController.Type,
                            presenter:BasePresenter.Type,
                            route:BaseRoute.Type) -> BaseViewController{
        
        let _viewController = viewController.init()
        
        let _route = route.init(viewController: _viewController)
        
        let _presenter = presenter.init(route: _route, viewController: _viewController)
        
        _viewController.presenter = _presenter
        
        return _viewController
    }
    
    public static func build(_ screen:BaseScreen) -> BaseViewController {
        let _viewControllerT = Base.classFromString("\(screen.screenName)ViewController") as! BaseViewController.Type
        
        let _viewController = _viewControllerT.init()
        
        _viewController.title = screen.screenTitle
        
        let _routeT = Base.classFromString("\(screen.screenName)Route") as! BaseRoute.Type
        
        let _route = _routeT.init(viewController: _viewController)
        
        let _presenterT = Base.classFromString("\(screen.screenName)Presenter") as! BasePresenter.Type
        
        let _presenter = _presenterT.init(route: _route, viewController: _viewController)
        
        _viewController.presenter = _presenter
        
        return _viewController
    }
    
    public static func build(moduleName name:String) -> BaseViewController {

        let _viewControllerT = Base.classFromString("\(name)ViewController") as! BaseViewController.Type
        
        let _viewController = _viewControllerT.init()
        
        let _routeT = Base.classFromString("\(name)Route") as! BaseRoute.Type

        let _route = _routeT.init(viewController: _viewController)
        
        let _presenterT = Base.classFromString("\(name)Presenter") as! BasePresenter.Type
        
        let _presenter = _presenterT.init(route: _route, viewController: _viewController)
        
        _viewController.presenter = _presenter
        
        return _viewController
    }
    
    @objc public static func classFromString(_ className:String) -> AnyClass {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName")
        let className = "\(appName!).\(className)"
        return NSClassFromString(className)!
    }
    
    public static func build(nibName:String?,
                             viewController:BaseViewController.Type,
                             presenter:BasePresenter.Type,
                             route:BaseRoute.Type) -> BaseViewController {
        
        let _viewController = viewController.init(nibName: nibName, bundle: nil)
        
        let _route = route.init(viewController: _viewController)
        
        let _presenter = presenter.init(route: _route, viewController: _viewController)
        
        _viewController.presenter = _presenter
        
        return _viewController
    }
    
    public static func validate(value:String,withExpression regex:String)->Bool {
        return NSPredicate(format:"SELF MATCHES %@", regex)
            .evaluate(with: value)
    }
}

public func RunAfter(delayInSeconds: TimeInterval, qos: DispatchQoS, execute work: @escaping @convention(block) () -> Swift.Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds,
                                  qos:qos,
                                  execute: work)
}


public func runOnMain(_ work: @escaping @convention(block) () -> Swift.Void) {
    DispatchQueue.main.async(execute: work)
}

extension Encodable {
    func encoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

extension Data {
    func decoded<T:Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}

