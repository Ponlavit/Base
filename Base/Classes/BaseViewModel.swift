
import Foundation


/// Contain model to display on view (one component per one model) and base functionality for view model
/// View Model does not need to have any private properties to hold information. Instead it can use the Domain Model properties in the Get and Set method of ViewModel Properties.
open class BaseViewModel : BaseModel {
    
    func getView() -> BaseView {
        if(self.getNibName() != nil && self.getNibName() != "") {
            return BaseView.buildFromNib(withModel: self)
        }
        return BaseView.build(withModel: self)
    }
    
    open func getNibName() -> String? {
        return self.nibName
    }
    
    public let name:String!
    public var nibName:String?
    
    public init(withName name:String!){
        self.name = name
    }

}
