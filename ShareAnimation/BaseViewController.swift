import UIKit

class BaseViewController: UIViewController {
    
    lazy var imageView = makeImageView()
    lazy var shareButton = makeShareButton()
    lazy var tableView = makeTableView()
    
    let users: [User] = [.init(id: 0, name: "Randdy Franci"),
                         .init(id: 1, name: "Kadin Dorwart"),
                         .init(id: 2, name: "Alfonso Gouse"),
                         .init(id: 3, name: "Cooper Torff"),
                         .init(id: 4, name: "James Dorwart"),
                         .init(id: 5, name: "Kuba Dorwart"),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        view.addSubview(imageView)
        view.addSubview(shareButton)
        
        imageView.anchor(
            .leading(view.leadingAnchor),
            .trailing(view.trailingAnchor),
            .top(view.topAnchor),
            .bottom(view.bottomAnchor)
        )
        
        shareButton.anchor(
            .leading(view.leadingAnchor, constant: 100),
            .trailing(view.trailingAnchor, constant: 100),
            .bottom(view.bottomAnchor, constant: 80),
            .height(48)
        )
    }
    
    @objc func shareButtonAction() {
        let vc = ShareVC(image: imageView.image!)
        vc.tableView = tableView
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension BaseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShareListTVCell", for: indexPath) as! ShareListTVCell
        cell.setupWith(title: users[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        72
    }
}

extension BaseViewController {
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    func makeShareButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
        return button
    }
    
    func makeTableView() -> UITableView {
        let tableView = TableView(style: .plain,
                                  backgroundColor: .white,
                                  cells: [ ShareListTVCell.self ])
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }
}

