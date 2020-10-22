import IGListKit

protocol ViewInterface: class {
    func showLoader(_ show: Bool, isFirstPage: Bool)
    
    func showData(_ data: [ListDiffable])
    func showData(_ data: [ListDiffable], scrollToItem item: ListDiffable)
    func reloadItem(_ item: ListDiffable)
}

extension ViewInterface {
    func showLoader(_ show: Bool, isFirstPage: Bool) {
        fatalError("Implementation pending...")
    }
    
    func showData(_ data: [ListDiffable]) {
        fatalError("Implementation pending...")
    }
    
    func showData(_ data: [ListDiffable], scrollToItem item: ListDiffable) {
        fatalError("Implementation pending...")
    }
    
    func reloadItem(_ item: ListDiffable) {
        fatalError("Implementation pending...")
    }
}
