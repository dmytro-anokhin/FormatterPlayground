//
// Playground for demonstrating formatting values with protocols and generics.
//
//  Created by Dmytro Anokhin on 13/01/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit
import PlaygroundSupport

extension FileManager {
    
    var freeSpace: Int64 {
        if let size = try? fileSystemFreeSize(at: NSHomeDirectory()) {
            return size
        }
        
        return 0
    }
    
    /// Returns the free size of the file system in bytes.
    func fileSystemFreeSize(at path: String) throws -> Int64 {
        let attributes = try attributesOfFileSystem(forPath: path)
        return attributes[FileAttributeKey.systemFreeSize] as! Int64
    }
}

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let shutterSpeedIndicator = FormattedIndicator(formatter: DefaultDecoratorFormatter(ShutterSpeedDecoratorFormatter(ShutterSpeedFormatter()), defaultString: "AUTO"))
        
        let exposureCompensationIndicator = FormattedIndicator(formatter: ExposureCompensationDecoratorFormatter(ExposureCompensationFormatter()))

        let freeSpaceIndicator = FormattedIndicator(formatter: FoundationFormatter<Int64>(ByteCountFormatter()))

        shutterSpeedIndicator.model = ShutterSpeed(numerator: 1, denominator: 50)
        exposureCompensationIndicator.model = 0.3
        freeSpaceIndicator.model = FileManager.default.freeSpace
    
        let stackView = UIStackView(arrangedSubviews: [
            shutterSpeedIndicator,
            exposureCompensationIndicator,
            freeSpaceIndicator
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16.0
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        self.view = view
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
