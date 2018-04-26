

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
}

