import UIKit


/// The FormattedIndicator is a subclass of the Indicator control that uses the FormatterType to convert a model to the textual representation.
open class FormattedIndicator<Model, Formatter: FormatterType>: Indicator where Model == Formatter.Model {

    open let formatter: Formatter
    
    public init(formatter: Formatter) {
        self.formatter = formatter
        super.init(frame: .zero)
        
        updateText()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open var model: Model? {
        didSet {
            updateText()
        }
    }
    
    private func updateText() {
        let attributes = formatter.attributes(for: UIApplication.shared.preferredContentSizeCategory)
        
        if let attributedText = formatter.attributedString(for: model, withAttributes: attributes) {
            self.attributedText = attributedText
        }
        else {
            self.text = formatter.string(for: model)
        }
    }
}
