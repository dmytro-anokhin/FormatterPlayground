import Foundation


/// The DecoratorFormatterType decorates string created by another formatter instance.
public protocol DecoratorFormatterType: FormatterType where Model == DecoratedFormatter.Model {

    associatedtype DecoratedFormatter
    
    var decoratedFormatter: DecoratedFormatter? { get set }
}


open class DecoratorFormatter<Model, D: FormatterType>: DecoratorFormatterType where Model == D.Model {
    
    public typealias DecoratedFormatter = D
    
    open var decoratedFormatter: DecoratedFormatter?

    public init(_ decoratedFormatter: DecoratedFormatter?) {
        self.decoratedFormatter = decoratedFormatter
    }
    
    open func string(for model: Model?) -> String? {
        return decoratedFormatter?.string(for: model)
    }

    open func attributedString(for model: Model?, withAttributes attributes: [NSAttributedStringKey : Any]?) -> NSAttributedString? {
        return decoratedFormatter?.attributedString(for: model, withAttributes: attributes)
    }
}


/// The DefaultDecoratorFormatter returns default string if the decorated formatter failed to create not empty string.
open class DefaultDecoratorFormatter<Model, D: FormatterType>: DecoratorFormatter<Model, D>  where Model == D.Model {

    open var defaultString: String?

    public convenience init(_ decoratedFormatter: D, defaultString: String) {
        self.init(decoratedFormatter)
        self.defaultString = defaultString
    }

    open override func string(for model: Model?) -> String? {
        if let string = super.string(for: model), !string.isEmpty {
            return string
        }

        return defaultString
    }
    
    open override func attributedString(for model: Model?, withAttributes attributes: [NSAttributedStringKey : Any]?) -> NSAttributedString? {
        if let attributedString = super.attributedString(for: model, withAttributes: attributes),
            attributedString.length > 0
        {
            return attributedString
        }

        if let defaultString = defaultString {
            return NSAttributedString(string: defaultString, attributes: attributes)
        }

        return nil
    }
}


