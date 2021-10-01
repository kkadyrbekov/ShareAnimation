import UIKit

class ShareListTVCell: UITableViewCell {
    
    private lazy var titleLabel = makeTitleLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setSubviews()
        setConstraints()
    }
    
    func setupWith(title: String) {
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShareListTVCell {
    public func setSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    public func setConstraints() {
        titleLabel.anchor(
            .leading(leadingAnchor, constant: 20),
            .trailing(trailingAnchor, constant: 20),
            .centerY(centerYAnchor)
        )
    }
}

private extension ShareListTVCell {
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        return label
    }
}
