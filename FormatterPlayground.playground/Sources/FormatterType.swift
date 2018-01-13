import UIKit


/// The type that declares objects that format values into the textual representation.
public protocol FormatterType {

    associatedtype Model

    func string(for model: Model?) -> String?

    func attributedString(for model: Model?, withAttributes attributes: [NSAttributedStringKey : Any]?) -> NSAttributedString?
}


extension FormatterType {

    public func attributedString(for model: Model?, withAttributes attributes: [NSAttributedStringKey : Any]?) -> NSAttributedString? {
        if let string = string(for: model) {
            return NSAttributedString(string: string, attributes: attributes)
        }
        else {
            return nil
        }
    }
}


extension NSAttributedStringKey {
    
    public static let smallFont: NSAttributedStringKey = .init(rawValue: "SmallFont")
}


extension FormatterType {

    func attributes(for contentSize: UIContentSizeCategory = UIApplication.shared.preferredContentSizeCategory) -> [NSAttributedStringKey : Any] {

        guard let font = UIFont(name: ".SFUIText-Medium", size: 13.0),
              let smallFont = UIFont(name: ".SFUIText-Medium", size: 11.0)
        else {
            assert(false, "Fonts are not available")
            return [:]
        }
    
        return [
            .font: font,
            .smallFont: smallFont
        ]
    }
}
