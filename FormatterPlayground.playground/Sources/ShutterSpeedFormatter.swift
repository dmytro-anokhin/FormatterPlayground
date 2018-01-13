import UIKit


open class ShutterSpeedFormatter: FormatterType {

    public typealias Model = ShutterSpeed

    public init() {
    }

    open func string(for model: Model?) -> String? {
        guard let model = model else { return nil }
        return model >= ShutterSpeed.second ? "\(model.numerator)\"" : "1/\(model.denominator)"
    }
    
    open func attributedString(for model: Model?, withAttributes attributes: [NSAttributedStringKey : Any]?) -> NSAttributedString? {
        guard   let model = model,
                let font = attributes?[.font] as? UIFont,
                let smallFont = attributes?[.smallFont] as? UIFont
        else {
            return nil
        }
        
        if model >= ShutterSpeed.second {
            return NSAttributedString(string: "\(model.numerator)\"", attributes: [ .font: font ])
        }
        else {
            let result = NSMutableAttributedString()
            
            result.append(
                NSAttributedString(string: "1/", attributes: [ .font: smallFont ])
            )
            result.append(
                NSAttributedString(string: "\(model.denominator)", attributes: [ .font: font ])
            )
            
            return result
        }
    }
}


/// The ShutterSpeedDecoratorFormatter decorates formatted string with S letter
open class ShutterSpeedDecoratorFormatter: DecoratorFormatter<ShutterSpeed, ShutterSpeedFormatter> {

    open override func string(for model: ShutterSpeed?) -> String? {
        guard let string = super.string(for: model) else { return nil }
        return "S \(string)"
    }

    open override func attributedString(for model: ShutterSpeed?, withAttributes attributes: [NSAttributedStringKey : Any]?) -> NSAttributedString? {
        guard let string = super.attributedString(for: model, withAttributes: attributes) else { return nil }

        let result = NSMutableAttributedString()
        let prefix = NSAttributedString(string: "S ", attributes: attributes)

        result.append(prefix)
        result.append(string)

        return result
    }
}

