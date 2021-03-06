import UIKit
import AltairMDKCommon

public protocol ExceptionViewDelegate: AnyObject {
    func didTapButtonAction(tag: Int)
}

public final class ExceptionView: UIView {
    public var delegate: ExceptionViewDelegate?
    
    lazy private var actionButton: UIButton = {
       let button = Button()
        button.addTarget(self, action: #selector(actionButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy private var titleLabel: UILabel = {
       setupTitleLabel()
    }()
    
    lazy private var messageLabel: UILabel = {
       setupMessageLabel()
    }()
    
    public convenience init(exception: Exception, actionButtonTitle: String? = nil) {
        self.init(frame: .zero)
        titleLabel.text = exception.errorTitle
        messageLabel.text = exception.errorDescription
        if let title = actionButtonTitle {
            actionButton.setTitle(title, for: .normal)
            actionButton.isHidden = false
            titleLabel.sizeToFit()
        }
        messageLabel.sizeToFit()
        actionButton.sizeToFit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSubviews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func actionButton(_ sender: UIButton) {
        delegate?.didTapButtonAction(tag: sender.tag)
    }
    
    public func setTag(_ value: Int) {
        actionButton.tag = value
    }

}

private extension ExceptionView {
    
    func setupView() {
        backgroundColor = Palette.background.uiColor
    }
    
    func setupSubviews() {
        addSubview(titleLabel)
        addSubview(messageLabel)
        addSubview(actionButton)
        setSubviewForAutoLayout(titleLabel)
        setSubviewForAutoLayout(messageLabel)
        setSubviewForAutoLayout(actionButton)
        actionButton.isHidden = true
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constraint.leading),
            messageLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Constraint.trailing)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -Constraint.top),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constraint.leading),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Constraint.trailing)
        ])
        
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            actionButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Constraint.bottom),
        ])
        
    }
    
}

private extension ExceptionView {
    
    enum Constraint {
        static let leading: CGFloat = 36.0
        static let trailing: CGFloat = 36.0
        static let top: CGFloat = 20.0
        static let bottom: CGFloat = 20.0
    }
    
    enum Font {
        static let title = UIFont.systemFont(ofSize: 22, weight: .semibold)
        static let message = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = Font.title
        label.textColor = Palette.primaryText.uiColor
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }
    
    func setupMessageLabel() -> UILabel {
        let label = UILabel()
        label.font = Font.message
        label.textColor = Palette.secondaryText.uiColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }

}
