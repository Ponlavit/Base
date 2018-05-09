//
//  BaseView.swift
//  Base
//
//  Created by Ponlavit Larpeampaisarl on 4/26/18.
//

import Foundation

open class BaseView : UIView {
    public var viewModel:BaseViewModel!

    open func setupView(){
        let adjustWidth = (self.superview?.frame.size.width)! * self.getPercentWidth() / 100
        let height = self.getHeight()
        self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: adjustWidth, height: height))
        self.setupAccessibilityId()
    }
    
    open func setupAccessibilityId() {
        self.accessibilityIdentifier = getModel().name
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
    
    public static func buildFromNib(withModel viewModel:BaseViewModel) -> BaseView {
        let view = viewModel.getNib()
        view.viewModel = viewModel
        viewModel.setView(view)
        return view;
    }
    
    public static func build(withModel viewModel:BaseViewModel) -> BaseView {
        return BaseView.build(withModel: viewModel, andFrame: CGRect.zero)
    }
    
    public static func build(withModel viewModel:BaseViewModel, andFrame frame:CGRect) -> BaseView {
        let view = BaseView(frame: frame)
        view.viewModel = viewModel
        viewModel.setView(view)
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
