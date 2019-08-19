//
//  UIImage+.swift
//  TasCar
//
//  Created by Enrique Canedo on 11/07/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import UIKit
import Kingfisher
import ImageIO
import MobileCoreServices
import CocoaLumberjack

enum DegradateOrientation {
    
    case horizontal, vertical, diagonalFromTopLeft, diagonalFromBottomLeft
    
    var startPoint: CGPoint {
        switch self {
        case .horizontal:
            return CGPoint(x: 0, y: 0.5)
        case .vertical:
            return CGPoint(x: 0.5, y: 0)
        case .diagonalFromTopLeft:
            return CGPoint(x: 0, y: 0)
        case .diagonalFromBottomLeft:
            return CGPoint(x: 0, y: 1)
        }
    }
    
    var endPoint: CGPoint {
        switch self {
        case .horizontal:
            return CGPoint(x: 1, y: 0.5)
        case .vertical:
            return CGPoint(x: 0.5, y: 1)
        case .diagonalFromTopLeft:
            return CGPoint(x: 1, y: 1)
        case .diagonalFromBottomLeft:
            return CGPoint(x: 0.5, y: 0)
        }
    }
    
    func startPointPosition(size: CGSize) -> CGPoint {
        switch self {
        case .horizontal:
            return CGPoint(x: 0.0, y: 0.0)
        case .vertical:
            return CGPoint(x: size.width / 2.0, y: 0.0)
        case .diagonalFromBottomLeft:
            return CGPoint(x: size.width, y: size.height)
        case .diagonalFromTopLeft:
            return CGPoint(x: size.width, y: 0.0)
        }
    }
    
    func endPointPosition(size: CGSize) -> CGPoint {
        switch self {
        case .horizontal:
            return CGPoint(x: size.width, y: 0.0)
        case .vertical:
            return CGPoint(x: size.width / 2.0, y: size.height)
        case .diagonalFromTopLeft:
            return CGPoint(x: 0.0, y: size.height)
        case .diagonalFromBottomLeft:
            return CGPoint(x: 0.0, y: 0.0)
        }
    }
    
}

extension UIImage {
    
    // MARK: - Properties
    
    /// Return a image data like a BaseImageProvider for change loading indicator correctly
    var imageProvider: BaseImageProvider? {
        guard let pngData = pngData() else { return nil }
        
        return BaseImageProvider(withImageData: pngData)
    }
    
    /// Return a averageColor from image
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull ?? kCFNotFound])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
    
    /// Degradate image with selected colors, orientation and size
    ///
    /// - Parameters:
    ///     - bounds : Size of patter image
    ///     - fromColor : Initial color
    ///     - toColor : Final color
    ///     - orientation : Orientation degradate
    /// - Returns: UIImage
    static func degradate(bounds: CGRect, fromColor: UIColor, toColor: UIColor, orientation: DegradateOrientation) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = orientation.startPoint
        gradientLayer.endPoint = orientation.endPoint
        gradientLayer.colors = [fromColor.cgColor, toColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = bounds
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, gradientLayer.isOpaque, 0.0)
        if let currentContext = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: currentContext)
        }
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
    
    /// Fills the alpha channel of the source image with the given color
    ///
    /// - Parameters:
    ///     - fillColor : Color for alpha channel
    /// - Returns: UIImage
    func fillAlpha(fillColor: UIColor) -> UIImage {
        return modifiedImage { context, rect in
            // draw tint color
            context.setBlendMode(.normal)
            fillColor.setFill()
            context.fill(rect)
            
            // mask by alpha values of original image
            context.setBlendMode(.destinationIn)
            context.draw(self.cgImage!, in: rect)
        }
    }
    
    /// Resize the image with the size of the height
    ///
    /// - Parameters:
    ///     - height : the size to be resized the image
    /// - Returns: UIImage?
    func resizeWithHeight(height: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: CGFloat(ceil(size.width * height/size.height)), height: height)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    /// Create a gif with array of images, this file save into Documents and override others
    ///
    /// - Parameters:
    ///     - withImages : Array of images
    ///     - fillColor: Color to change alpha
    static func animatedGif(withImages images: [UIImage], fillColor color: UIColor = ThemeColor.main.color, completion: CompletionURL?) {
        let fileProperties: CFDictionary = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: Double.zero]]  as CFDictionary
        let frameProperties: CFDictionary = [kCGImagePropertyGIFDictionary as String: [(kCGImagePropertyGIFDelayTime as String): Animation.timeInterval]] as CFDictionary
        // Destination URL
        let documentsDirectoryURL: URL? = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL: URL? = documentsDirectoryURL?.appendingPathComponent("\(Files.fileGif + color.toHexString()).\(Files.fileGifExtension)")
        if let url = fileURL, FileManager.default.fileExists(atPath: url.path) {
            completion?(fileURL)
        } else if let cfURL = fileURL as CFURL?, 
            let destination = CGImageDestinationCreateWithURL(cfURL, kUTTypeGIF, images.count, nil) {
            CGImageDestinationSetProperties(destination, fileProperties)
            for image in images {
                if let cgImage = image.fillAlpha(fillColor: color).cgImage {
                    CGImageDestinationAddImage(destination, cgImage, frameProperties)
                }
            }
            if !CGImageDestinationFinalize(destination) {
                DDLogError("Failed to finalize the image destination")
                completion?(nil)
            } else {
                completion?(fileURL)
            }
        } else {
            completion?(nil)
        }
    }
    
    // MARK: - Private functions
    
    private func modifiedImage(draw: (CGContext, CGRect) -> Void) -> UIImage {
        // using scale correctly preserves retina images
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context: CGContext! = UIGraphicsGetCurrentContext()
        assert(context != nil)
        
        // correctly rotate image
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        
        draw(context, rect)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return image
        } else {
            return UIImage()
        }
    }
    
}
