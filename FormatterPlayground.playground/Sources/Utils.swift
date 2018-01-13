import UIKit

extension UIEdgeInsets {

    public var width: CGFloat { return left + right }
    
    public var height: CGFloat { return top + bottom }
}

extension CGSize {

    public static func +(size: CGSize, edgeInsets: UIEdgeInsets) -> CGSize {
        return CGSize(width: size.width + edgeInsets.width, height: size.height + edgeInsets.height)
    }
    
    public static func -(size: CGSize, edgeInsets: UIEdgeInsets) -> CGSize {
        return CGSize(width: size.width - edgeInsets.width, height: size.height - edgeInsets.height)
    }
}
