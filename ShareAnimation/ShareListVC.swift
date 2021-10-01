import UIKit

struct User {
    let id: Int
    let name: String
}

protocol ShareListVCDelegate: AnyObject {
    func willTransition(to view: UIView, vc: ShareListVC)
    func willDismiss(vc: ShareListVC)
    func willTransition(to: PanModalPresentationController.PresentationState)
}

class ShareListVC: UIViewController {
    
    lazy var tableView = makeTableView()
    weak var delegate: ShareListVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setSubviews()
    }
    
    func setSubviews() {
        view.addSubview(tableView)
        
        tableView.anchor(
            .leading(view.leadingAnchor),
            .trailing(view.trailingAnchor),
            .top(view.topAnchor),
            .bottom(view.bottomAnchor)
        )
    }
}

extension ShareListVC: PanModalPresentable {
    
    var panScrollable: UIScrollView? { tableView }
    
    var screenHeight: CGFloat { UIScreen.main.bounds.height }
    
    var longFormHeight: PanModalHeight { .contentHeight(screenHeight * 0.5) }
    
    var shortFormHeight: PanModalHeight { longFormHeight }
    
    var panModalBackgroundColor: UIColor { .clear }
    
    var dragIndicatorBackgroundColor: UIColor { .clear }
    
    func willTransition(to state: PanModalPresentationController.PresentationState) {
        delegate?.willTransition(to: state)
    }
    
    func willTransition(to vc: PanModalPresentationController) {
        delegate?.willTransition(to: vc.presentedView, vc: self)
    }
    
    func panModalWillDismiss() {
        delegate?.willDismiss(vc: self)
    }
}

extension ShareListVC {
    func makeTableView() -> UITableView {
        let tableView = TableView(style: .plain,
                                  backgroundColor: .white,
                                  cells: [ ShareListTVCell.self ])
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }
}

