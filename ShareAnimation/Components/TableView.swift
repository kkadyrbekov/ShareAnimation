import UIKit

open class TableView: UITableView {
    public init(
        style: UITableView.Style = .plain,
        refreshControl: UIRefreshControl? = nil,
        backgroundColor: UIColor = .clear,
        allowsSelection: Bool = true,
        allowsMultipleSelectionDuringEditing: Bool = false,
        cells: [AnyClass] = [],
        automaticDimentioned: Bool = false,
        delegate: UITableViewDelegate? = nil,
        dataSource: UITableViewDataSource? = nil,
        contentInset: UIEdgeInsets = .zero
    ) {
        super.init(frame: .zero, style: style)
        
        if automaticDimentioned {
            self.rowHeight = UITableView.automaticDimension
            self.estimatedRowHeight = UITableView.automaticDimension
        }
        self.contentInset = contentInset
        if let delegate = delegate {
            self.delegate = delegate
        }
        if let dataSource = dataSource {
            self.dataSource = dataSource
        }
        self.refreshControl = refreshControl
        self.backgroundColor = backgroundColor
        self.allowsSelection = allowsSelection
        self.allowsMultipleSelectionDuringEditing = allowsMultipleSelectionDuringEditing
        cells.forEach { register($0, forCellReuseIdentifier: String(describing: $0)) }
        self.showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        separatorStyle = .none
        alwaysBounceVertical = false
        self.backgroundView?.isHidden = false
        self.backgroundView?.alpha = 0
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}
