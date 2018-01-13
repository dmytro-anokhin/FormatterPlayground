import Foundation


open class FoundationFormatter<Model>: FormatterType {
    
    open var formatter: Foundation.Formatter?

    public init(_ formatter: Foundation.Formatter?) {
        self.formatter = formatter
    }
    
    open func string(for model: Model?) -> String? {
        return formatter?.string(for: model)
    }
}
