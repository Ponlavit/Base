
import Foundation


/// Contain model to display on view (one component per one model) and base functionality for view model
/// View Model does not need to have any private properties to hold information. Instead it can use the Domain Model properties in the Get and Set method of ViewModel Properties.
open class BaseViewModel : BaseModel {

    public let name:String!
    public private(set) var nibName:String?
    weak var view: BaseView?
    open var onSetupView : ((_ view:BaseView) -> Swift.Void)?

    public func getView() -> BaseView {
        if(self.view != nil) {
            return self.view!
        }
        if(self.getNibName() != nil && self.getNibName() != "") {
            return BaseView.buildFromNib(withModel: self)
        }
        return BaseView.build(withModel: self)
    }
    
    func setView(_ view:BaseView){
        self.view = view
    }
    
    open func getNibName() -> String? {
        return self.nibName
    }
    
    public func getNibView() -> BaseView {
        let view = self.getNib().instantiate(withOwner: nil, options: nil)[0] as! BaseView
        view.accessibilityIdentifier = self.name
        return view
    }
    
    open func getNib() -> UINib {
        return UINib(nibName: self.nibName!, bundle: nil)
    }
    
    public init(withName name:String!, nibName:String!){
        self.name = name
        self.nibName = nibName
    }
}
