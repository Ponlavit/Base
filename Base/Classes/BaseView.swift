//
//  BaseView.swift
//  Base
//
//  Created by Ponlavit Larpeampaisarl on 4/26/18.
//

import Foundation

open class BaseView : UIView {
    public var viewModel:BaseViewModel!
    
    open func setupView(){}
    
    open func getModel() -> BaseViewModel { return self.viewModel }
    
    class func instanceFromNib(nibName name:String!) -> BaseView {
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BaseView
    }
    
    public static func buildFromNib(withModel viewModel:BaseViewModel) -> BaseView {
        guard let nibName = viewModel.getNibName() else {
            fatalError("Cannot get nibName, need to override getNibName() or use func build(withModel:) instead ")
        }
        let view = BaseView.instanceFromNib(nibName:nibName)
        view.viewModel = viewModel
        return view;
    }
    
    public static func build(withModel viewModel:BaseViewModel) -> BaseView {
        return BaseView.build(withModel: viewModel, andFrame: CGRect.zero)
    }
    
    public static func build(withModel viewModel:BaseViewModel, andFrame frame:CGRect) -> BaseView {
        let view = BaseView(frame: frame)
        view.viewModel = viewModel
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
