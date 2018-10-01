import Foundation
// MARK: - 颜色扩展
extension UIColor {
    
    /// 颜色值
    ///
    /// - Parameters:
    ///   - r: red
    ///   - g: green
    ///   - b: blue
    public convenience init(red r:Int, green g:Int, blue b:Int) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
    }
    
    /// 16进制数 转换成颜色
    ///
    /// - Parameter color: hex值
    public convenience init(hexValue:NSInteger) {
        self.init(red: (hexValue & 0xFF0000) >> 16, green: (hexValue & 0x00FF00) >> 8, blue: (hexValue & 0x0000FF))
    }
}


// MARK: - 颜色扩展
extension UIColor {
    
    /// 获取white alpha
    ///
    /// - Returns: white alpha
    public func whiteComponent() -> (white: CGFloat, alpha: CGFloat) {
        var whiteC: CGFloat = 0
        var alphaC: CGFloat = 0
        getWhite(&whiteC, alpha: &alphaC)
        return (whiteC, alphaC)
    }
    
    /// 获取 r g b a
    ///
    /// - Returns: 获取rgba部分
    public func rgbComponent() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var redC: CGFloat = 0
        var greenC: CGFloat = 0
        var blueC: CGFloat = 0
        var alphaC: CGFloat = 0
        getRed(&redC, green: &greenC, blue: &blueC, alpha: &alphaC)
        return (redC, greenC, blueC, alphaC)
    }
    
    /// 获取hsba部分
    ///
    /// - Returns: 获取hsba
    public func hsbComponent() -> (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hueC: CGFloat = 0
        var saturationC: CGFloat = 0
        var brightnessC: CGFloat = 0
        var alphaC: CGFloat = 0
        getHue(&hueC, saturation: &saturationC, brightness: &brightnessC, alpha: &alphaC)
        return (hueC, saturationC, brightnessC, alphaC)
    }
    
    /// white
    var white: CGFloat {
        return whiteComponent().white
    }
    
    /// alpha
    var alpha: CGFloat {
        return whiteComponent().alpha
    }
    
    /// red
    var red : CGFloat {
        return rgbComponent().red
    }
    
    /// green
    var green: CGFloat {
        return rgbComponent().green
    }
    
    /// blue
    var blue: CGFloat {
        return rgbComponent().blue
    }
    
    /// hue
    var hue: CGFloat  {
        return hsbComponent().hue
    }
    
    /// saturation
    var saturation: CGFloat  {
        return hsbComponent().saturation
    }
    
    /// brightness
    var brightness: CGFloat  {
        return hsbComponent().brightness
    }
    
}
