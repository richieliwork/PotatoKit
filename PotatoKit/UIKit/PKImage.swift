import Foundation
// MARK: - 图片扩展
extension UIImage {
    
    /// 颜色转换成图片
    ///
    /// - Parameters:
    ///   - c: 颜色
    ///   - s: 大小
    /// - Returns: UIImage or nil
    public static func imageFromColor(color c:UIColor, size s:CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        UIGraphicsBeginImageContext(s)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(c.cgColor)
        context.fill(CGRect(origin: CGPoint.zero, size: s))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
    /// 将链接转换成二维码
    ///
    /// - Parameters:
    ///   - string: 链接
    ///   - length: 高度 width == height
    /// - Returns: 转换后的二维码
    public static func imageFromURL(url string: String, size length:CGFloat) -> UIImage? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator"),
            let data = string.data(using: String.Encoding.utf8) else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(data, forKey: "inputMessage");
        filter.setValue("H", forKey: "inputCorrectionLevel")
        guard let output = filter.outputImage else {
            return nil
        }
        let scale = UIScreen.main.scale
        return UIImage(ciImage: output.imageScaledToSize(size: length * scale) , scale: scale, orientation: UIImage.Orientation.up)
    }
    
    /// 获取qrcode 的链接
    ///
    /// - Returns: 如果有内容 会生成一个字符串 如果不存在字符串就返回nil
    public func qrcodeInformation() -> String? {
        guard let dector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]), let ciImage = CIImage(image: self) else { return nil }
        
        let features = dector.features(in: ciImage)
        guard let qrcodes = features as? [CIQRCodeFeature], features.count > 0 else { return nil }
        return qrcodes[0].messageString
    }
}


// MARK: - CIImage 扩展
extension CIImage {
    
    /// 图片放大制定的倍数
    ///
    /// - Parameter size: 放大的倍数
    /// - Returns: 缩放后的CIImage
    public func imageScaled(scale scaled: CGFloat) -> CIImage {
        return self.imageScaled(scaleX: scaled, scaleY: scaled)
    }
    
    
    /// 对图片进行缩放
    ///
    /// - Parameters:
    ///   - scaleX: x 缩放的倍数
    ///   - scaleY: y 缩放的倍数
    /// - Returns: 缩放后的图片
    public func imageScaled(scaleX: CGFloat, scaleY: CGFloat) -> CIImage {
        return self.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
    }
    
    
    /// 缩放到指定的尺寸
    ///
    /// - Parameter length: 尺寸 width == height
    /// - Returns: 图片缩放到指定尺寸
    public func imageScaledToSize(size length: CGFloat) -> CIImage {
        return self.imageScaled(scale: length / self.extent.width)
    }
    
    
    /// 缩放到指定的尺寸
    ///
    /// - Parameters:
    ///   - width: 高
    ///   - height: 宽
    /// - Returns: 转换后的CIImage
    public func imageScaledToSize(size width: CGFloat, height: CGFloat) -> CIImage {
        return self.imageScaled(scaleX: width / self.extent.width, scaleY: height / self.extent.height)
    }
    
}
