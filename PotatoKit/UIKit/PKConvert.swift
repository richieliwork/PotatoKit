import Foundation

extension UIView {
    
    /// 将UIView的内容保存下来
    ///
    /// - Returns: 返回图片
    public func contentAsImage() -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
            return renderer.image(actions: { rendererContext in
                layer.render(in: rendererContext.cgContext)
            })
        } else {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, UIScreen.main.scale)
            defer {
                UIGraphicsEndImageContext()
            }
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
    }
}
