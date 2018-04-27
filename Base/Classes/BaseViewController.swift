
import Foundation


/// Contain view for one page screen, contain base functionality to render the subview
open class BaseViewController: UIViewController {
    
    /*! @brief as output to acknowledge action to presenter */
    public internal(set) var presenter:BasePresenter!
    
    public required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewIsReady()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.presenter.viewIsGone()
    }
    
    public func addSubview(with viewModel:BaseViewModel, on origin:CGPoint){
        let view = viewModel.getView()
        view.setupView()
        view.bind()
        view.frame.origin = origin
        self.view.addSubview(view)
    }
    
    open func getPresenter() -> BasePresenter{
        fatalError("must override to get concrete presenter")
    }
}


