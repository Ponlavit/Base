
import Foundation

/// Presenter will be acting like a bridge between, View, ViewModel and Model. This will take care of getting data from Model and pass it to View through View model. ViewModel will have only the properties which are used to Bind data to View and hold data that comes from View. Presenter will have other implementations to talk to business layer and get domain model and update view model to pass the information to View.
open class BasePresenter : NSObject {
    
    /*! @brief as view action to continue perform route action */
    public let route:BaseRoute!
    /*! @brief update back to view if need (suggestion using Rx) */
    public private(set) weak var view:BaseViewController!
    
    public var presenterModel:Any?
    
    public required init(route:BaseRoute, viewController: BaseViewController){
        self.route = route
        self.view = viewController
    }
        
    /*! @brief do some initial for view */
    open func viewIsReady() {
        
    }
    
    open func viewWillAppear() {
        
    }
    
    open func viewWillDisappear(){
        
    }
    
    /*! @brief get the main route object */
    open func getRoute() -> BaseRoute {
        fatalError("must override to get concrete route")
    }
    
    /*! @brief get corresponding view controller  */
    open func getView() -> BaseViewController {
        fatalError("must override to get concrete view controller")
    }
    
    /*! @brief do some release or remove data for view */
    open func viewIsGone() {
        
    }
    
    /*! @brief get corresponding view controller main view width  */
    public func getWidth() -> CGFloat{
        return self.getView().view.frame.size.width
    }
    
    public func getHeight() -> CGFloat{
        return self.getView().view.frame.size.height
    }
    
    /*! @brief get corresponding view controller main view width in percent width  */
    public func getWidth(percent: CGFloat) -> CGFloat {
        return self.getWidth() * percent / 100.0
    }
    
    /*! @brief get corresponding view controller main view width in percent height  */
    public func getHeight(percent: CGFloat) -> CGFloat {
        return self.getHeight() * percent / 100.0
    }
    
    public func positionUnder(_ view:BaseView?, withMargin margin:CGFloat) -> CGFloat{
        guard let notNilView = view else {
            return 0 + margin
        }
        let zeroMargin = notNilView.frame.origin.y + notNilView.frame.size.height
        return zeroMargin + margin
    }
    
    public func positionNextTo(_ view:BaseView?, withMargin margin:CGFloat) -> CGFloat{
        guard let notNilView = view else {
            return 0 + margin
        }
        let zeroMargin = notNilView.frame.origin.x + notNilView.frame.size.width
        return zeroMargin + margin
    }
    
    public func addSubview(_ viewModel:BaseViewModel,under topViewModel:BaseViewModel?, withTopMargin marginTop:CGFloat, andLeftMargin marginLeft:CGFloat) {
        
        self.addSubView(intoView: self.getView().view, with: viewModel, under: topViewModel, withTopMargin: marginTop, andLeftMargin: marginLeft)
    }
    
    public func getTopMargin() -> CGFloat{
        return UIApplication.shared.statusBarFrame.height + ((self.getView().navigationController?.navigationBar.frame.size.height) ?? 0)
    }
    
    public func addSubView(intoView:UIView, with viewModel:BaseViewModel,under topViewModel:BaseViewModel?, withTopMargin marginTop:CGFloat, andLeftMargin marginLeft:CGFloat){
        
        var nextY = self.positionUnder(topViewModel?.view, withMargin: marginTop)
        
        if(topViewModel != nil){
            if(topViewModel?.view?.isHidden)!{
                nextY = self.positionUnder(nil, withMargin: marginTop)
            }
        }
        
        self.getView().addSubview(intoView: intoView, with: viewModel, on: CGPoint(
            x:marginLeft,
            y:nextY))
    }
    
    public func addSubview(intoView:UIView,nextTo viewModel:BaseViewModel, with:BaseViewModel, withSpace margin:CGFloat){
        var nextX = self.positionNextTo(viewModel.view, withMargin: margin)
        
        if(viewModel.view?.isHidden)!{
            nextX = self.positionNextTo(nil, withMargin: margin)
        }
        
        self.getView().addSubview(intoView: intoView, with: with, on: CGPoint(
            x:nextX,
            y:(viewModel.view?.frame.origin.y)!))
    }
}
