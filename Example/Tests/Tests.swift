
import Quick
import Nimble
import Base


public class InstanceViewController : BaseViewController{
    
}


class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("Base") {
            
            describe("test builder"){
                let vc = Base.build(viewController: BaseViewController.self,
                                    presenter: BasePresenter.self,
                                    route: BaseRoute.self)
                it("can be initial"){
                    expect(vc).toNot(beNil())
                }
                
                it("is return correctly"){
                    expect(vc).to(beAKindOf(BaseViewController.self))
                }
                
                it("can grab presenter"){
                    expect(vc.presenter).toNot(beNil())
                }
                
                it("is vc isSubclass correctly"){
                    expect(vc.presenter).to(beAKindOf(BasePresenter.self))
                }
                
                it("can track back to view"){
                }
            }
        }
    }
}
