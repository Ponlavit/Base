
import Foundation
import SwiftOverlays

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
        self.automaticallyAdjustsScrollViewInsets = true
        self.view.backgroundColor = .white
        self.setHideKeyboard()
        self.presenter.viewIsReady()
    }
    
    private func setHideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.presenter.viewIsGone()
    }
    
    public func addSubview(with viewModel:BaseViewModel, on origin:CGPoint){
        self.addSubview(intoView: self.view, with: viewModel, on: origin)
    }
    
    public func addSubview(intoView targetView:UIView, with viewModel:BaseViewModel, on origin:CGPoint){
        let view = viewModel.getView()
        view.frame.origin = origin
        targetView.addSubview(view)
        view.setupView()
        view.bind()
    }
    
    public func showWaitOverlayWithText(_ text:String, isBlock: Bool){
        if(isBlock){
            SwiftOverlays.showBlockingWaitOverlayWithText(text)
        }
        else{
            self.showWaitOverlayWithText(text)
        }
    }
    
    
    public func showAutoCloseOverlay(_ text:String, iconImage:UIImage, closeIn:TimeInterval, isBlock:Bool? = false){
        
        var overlayView : UIView?
        
        if(isBlock)! {
            overlayView = SwiftOverlays.showBlockingImageAndTextOverlay(iconImage, text: text)
        }
        else {
            overlayView = SwiftOverlays.showImageAndTextOverlay(self.view, image:iconImage, text: text)
        }
        
        
        Timer.scheduledTimer(timeInterval: closeIn, target: self, selector: #selector(hideAutoCloseOverlay(timer:)), userInfo: overlayView, repeats: false)
    }
    
    @objc func hideAutoCloseOverlay(timer:Timer?){
        (timer?.userInfo as! UIView).removeFromSuperview()
    }
    
    public func hideAllOverlay(){
        SwiftOverlays.removeAllBlockingOverlays()
        self.removeAllOverlays()
    }
    
    open func getPresenter() -> BasePresenter{
        fatalError("must override to get concrete presenter")
    }
}


