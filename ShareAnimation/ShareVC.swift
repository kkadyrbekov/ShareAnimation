import UIKit

class ShareVC: UIViewController {
    
    var image: UIImage
    lazy var imageView = makeImageView()
    lazy var tableView = makeTableView()
    
    var imageViewConstraints: AnchoredConstraints?
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        imageView.image = image
        setSubviews()
        
        let shareListVC = ShareListVC()
        shareListVC.delegate = self
        shareListVC.tableView = self.tableView
        self.presentPanModal(shareListVC)
        
        DispatchQueue.main.async {
            self.imageViewConstraints?.bottom?.constant = -((UIScreen.main.bounds.height * 0.5) + self.view.safeAreaInsets.top)
            self.imageViewConstraints?.top?.constant = self.view.safeAreaInsets.top
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func setSubviews() {
        view.addSubview(imageView)
        
        imageViewConstraints = imageView.anchor(
            .leading(view.leadingAnchor),
            .trailing(view.trailingAnchor),
            .top(view.topAnchor),
            .bottom(view.bottomAnchor)
        )
    }
}

extension ShareVC: ShareListVCDelegate {
    func willTransition(to view: UIView, vc: ShareListVC) {
        imageViewConstraints?.bottom?.constant = -(UIScreen.main.bounds.height - view.frame.origin.y + (self.view.safeAreaInsets.top / 3))
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    func willDismiss(vc: ShareListVC) {
        imageViewConstraints?.bottom?.constant = 0
        imageViewConstraints?.top?.constant = 0
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        } completion: { finished in
            UIView.transition(with: self.imageView, duration: 0.3, options: .transitionCrossDissolve) {
                self.imageView.contentMode = .scaleAspectFill
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.navigationController?.popViewController(animated: false)
            }
        }
    }
    
    func willTransition(to: PanModalPresentationController.PresentationState) {
        self.imageViewConstraints?.bottom?.constant = -((UIScreen.main.bounds.height * 0.5) + self.view.safeAreaInsets.top)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension ShareVC {
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func makeTableView() -> UITableView {
        let tableView = TableView(style: .plain,
                                  backgroundColor: .white,
                                  cells: [ ShareListTVCell.self ])
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }
}

