import Foundation

class BaseViewController: UIViewController {
    
    var presenter:BasePresenter!
    
    /**
        As dependency Injection we can change presenter to make our
        view controller to work differently
    */
    static func build(presenter: BasePresenter) -> BaseViewController{
        let controller = BaseViewController()
        controller.presenter = presenter
        return controller
    }
}
