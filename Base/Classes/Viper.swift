import Foundation

public class Viper {
    public static func bind(view:BaseViewController.Type,
                            interactor:BaseInteractor,
                            presenter:BasePresenter,
                            entities:[BaseEntity],
                            route:BaseRoute) -> BaseViewController{
        
        let vc = view.init()
        vc.presenter = presenter
        
        route.viewController = vc
        
        presenter.interactor = interactor
        presenter.routes = route
        presenter.view = vc
        
        interactor.entities = entities
        interactor.presenter = presenter
        
        return vc
    }
}
