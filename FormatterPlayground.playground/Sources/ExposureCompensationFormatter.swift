import Foundation


open class ExposureCompensationFormatter: FormatterType {

    public typealias Model = Double

    public init() {
    }

    open func string(for model: Model?) -> String? {
        guard let model = model else { return nil }
        switch model {
            case 0.0:
                return "±\(model)"
            case _ where model > 0.0:
                return "+\(model)"
            default:
                return "\(model)"
        }
    }
}


/// The ExposureCompensationDecoratorFormatter decorates formatted string with ☀︎ symbol
open class ExposureCompensationDecoratorFormatter: DecoratorFormatter<Double, ExposureCompensationFormatter> {

    open override func string(for model: Double?) -> String? {
        guard let string = super.string(for: model) else { return nil }
        return "☀︎ \(string)"
    }
    
    open override func attributedString(for model: Double?, withAttributes attributes: [NSAttributedStringKey : Any]?) -> NSAttributedString? {
        guard let string = super.attributedString(for: model, withAttributes: attributes) else { return nil }

        let result = NSMutableAttributedString()
        let prefix = NSAttributedString(string: "☀︎ ", attributes: attributes)

        result.append(prefix)
        result.append(string)

        return result
    }
}
