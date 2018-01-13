import UIKit


/// The Indicator is a base class for controls that represent capture settings.
open class Indicator: UIControl {

    // MARK: Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        init_Indicator()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        init_Indicator()
    }
    
    private func init_Indicator() {
        updateStyle()
        
        layer.cornerRadius = 2.0
        
        addSubview(label)
        clipsToBounds = true
    }

    // MARK: Public
    
    open var text: String? {
        get {
            return label.text
        }
        
        set {
            label.text = newValue
            invalidateIntrinsicContentSize()
        }
    }
    
    open var attributedText: NSAttributedString? {
        get {
            return label.attributedText
        }
        
        set {
            label.attributedText = newValue
            invalidateIntrinsicContentSize()
        }
    }
    
    public enum Style {
        case `default`
        
        case inverted
    }
    
    open var style: Style = .`default` {
        didSet {
            updateStyle()
        }
    }
    
    // MARK: UIView
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(
            x: Indicator.edgeInsets.left,
            y: Indicator.edgeInsets.top,
            width: bounds.width - Indicator.edgeInsets.width,
            height: bounds.height - Indicator.edgeInsets.height
        )
    }
    
    open override var intrinsicContentSize: CGSize {
        return label.intrinsicContentSize + Indicator.edgeInsets
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let availableSize = size - Indicator.edgeInsets
        
        guard availableSize.width > 0.0 && availableSize.height > 0.0 else {
            return .zero
        }
        
        let labelSize = label.sizeThatFits(availableSize)
        return labelSize + Indicator.edgeInsets
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        let widthDelta = max(44.0 - bounds.size.width, 0.0)
        let heightDelta = max(44.0 - bounds.size.height, 0.0)
        
        let extendedBounds = bounds.insetBy(
            dx: -1.0 * widthDelta * 0.5,
            dy: -1.0 * heightDelta * 0.5
        )

        return extendedBounds.contains(point) ? self : nil
    }
    
    // MARK: Private
    
    private static var edgeInsets = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
    
    private let label = UILabel()
    
    private func updateStyle() {
        switch style {
            case .`default`:
                backgroundColor = UIColor(red: 248.0/255.0, green: 238.0/255.0, blue: 28.0/255.0, alpha: 1.0)
                label.textColor = UIColor(white: 0.1, alpha: 1.0)
            case .inverted:
                backgroundColor = UIColor(white: 0.0, alpha: 0.5)
                label.textColor = UIColor(red: 255.0/255.0, green: 251.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        }
    }
}
