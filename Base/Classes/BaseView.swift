//
//  BaseView.swift
//  Base
//
//  Created by Ponlavit Larpeampaisarl on 4/26/18.
//

import Foundation

public protocol BaseViewLC {
    func setupView()
    func bind()
    func setupAccessibilityId()
}

open class BaseView : UIView, BaseViewLC {
    public weak private(set) var viewModel:BaseViewModel!

    open func setupView(){
        let adjustWidth = (self.superview?.frame.size.width)! * self.getPercentWidth() / 100
        let height = self.getHeight()
        self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: adjustWidth, height: height))
        if(self.getModel().onSetupView != nil) {
            self.getModel().onSetupView!(self)
        }
        self.setupAccessibilityId()
    }
    
    open func setupAccessibilityId() {
        self.accessibilityIdentifier = getModel().name ?? NSStringFromClass(self.classForCoder)
    }
    
    open func getPercentWidth() -> CGFloat {
        return 100
    }
    
    open func getHeight() -> CGFloat {
        return (self.viewModel.view?.frame.size.height)!
    }
    
    open func bind(){
    }
    
    open func getModel() -> BaseViewModel {
        fatalError("must override to get concrete view model")
    }
    
    public func changeViewModel(withNewModel newViewModel:BaseViewModel){
        self.viewModel = newViewModel
        self.setupView()
        self.bind()
    }
    
    static func buildFromNib<T:BaseView>(withModel viewModel:BaseViewModel) -> T {
        let view : T = viewModel.getNibView() as! T
        view.viewModel = viewModel
        viewModel.setView(view)
        return view;
    }
    
    public static func build<T:BaseView>(withModel viewModel:BaseViewModel) -> T {
        let ret : T = T.build(withModel: viewModel, andFrame: CGRect.zero)
        return ret
    }
    
    public static func build<T:BaseView>(withModel viewModel:BaseViewModel, andFrame frame:CGRect) -> T {
        let aClass  = T.self
        let view = aClass.init(frame: CGRect.zero)
        view.viewModel = viewModel
        viewModel.setView(view)
        return view
    }
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}




