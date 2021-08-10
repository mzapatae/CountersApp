import UIKit
import Design
import AltairMDKCommon

final class CreateCounterView: UIView {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        setupActivityIndicator()
    }()
    
    lazy var titleTextField: UITextField = {
        setupTitleTextField()
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupSubviews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CreateCounterView {
    
    func setupView() {
        backgroundColor = Palette.background.uiColor
    }
    
    func setupSubviews() {
        addSubview(titleTextField)
        addSubview(activityIndicator)
        setSubviewForAutoLayout(titleTextField)
        setSubviewForAutoLayout(activityIndicator)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: TitleTextFieldConstant.top),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: TitleTextFieldConstant.leading),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -TitleTextFieldConstant.trailing),
            titleTextField.heightAnchor.constraint(equalToConstant: TitleTextFieldConstant.height)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: titleTextField.centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor, constant: -ActivityIndicatorConstant.leading)
        ])
        
        
    }
    
}

private extension CreateCounterView {
    
    enum TitleTextFieldConstant {
        static let leading: CGFloat = 12.0
        static let trailing: CGFloat = 12.0
        static let top: CGFloat = 25.0
        static let height: CGFloat = 55.0
        static let cornerRadius: CGFloat = 8.0
        static let paddingLeft: CGRect = CGRect(x: 0, y: 0, width: 17, height: 50)
        static let paddingRight: CGRect = CGRect(x: 0, y: 0, width: 40, height: 50)

    }
    
    enum ActivityIndicatorConstant {
        static let leading: CGFloat = 12.0
    }
    
    enum Font {
        static let hint = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let text = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    func setupTitleTextField() -> UITextField {
        let textField = UITextField()
        textField.setupKeyboard(.normal, returnKeyType: .continue)
        textField.placeholder = Locale.textFieldHintExampleTitle.localized
        textField.textColor = Palette.primaryText.uiColor
        textField.set(cornerRadius: TitleTextFieldConstant.cornerRadius)
        textField.layer.masksToBounds = true
        textField.layer.backgroundColor = Palette.textfield.uiColor.cgColor
        textField.leftView = UIView(frame: TitleTextFieldConstant.paddingLeft)
        textField.rightView = UIView(frame: TitleTextFieldConstant.paddingRight)
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.clearButtonMode = .never
        return textField
    }
    
    func setupActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.bringSubviewToFront(self)
        return activityIndicator
    }
    
    
}
