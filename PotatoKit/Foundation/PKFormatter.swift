import Foundation



// MARK: - 格式化输出字符串
extension String {
    
    /// 转换成数字的格式(带千分位)
    ///
    /// - Returns: 带, 数字的格式
    public func intFormatter(default defaultString: String = "0") -> String {
        
        guard let intValue = Int(self) else {
            return defaultString;
        }
        return intValue.numberFormatter() ?? defaultString
    }
    
    /// 转换成float数字格式(带千分位)
    ///
    /// - Parameters:
    ///   - length: 小数点后的长度
    ///   - defaultString: 默认的字符串
    /// - Returns: 转换成小数点后length长度的字符串
    public func floatFormatter(decimal length:Int = 2, default defaultString: String = "0.00") -> String {
        guard let floatValue = Float(self) else {
            return defaultString
        }
        return floatValue.numberFormatter(decimal: length) ?? defaultString
    }
    
    
}


// MARK: - 格式化
extension Int {
    /// 数字格式
    ///
    /// - Parameter defaultString: 默认 转换失败的
    /// - Returns: 数字格式化后的字符串
    public func numberFormatter() -> String? {
        let formatter = NumberFormatter()
        formatter.positiveFormat = "#,##0"
        return formatter.string(from: NSNumber(value: self))
    }
}


// MARK: - 格式化
extension Float {
    
    /// 转换成带带千分位的格式
    ///
    /// - Parameters:
    ///   - length: decimal 长度
    ///   - defaultString: 默认的长度
    /// - Returns: 带千分位 而且小数点后为length长度的字符串
    public func numberFormatter(decimal length:Int = 2) -> String? {
        let formatter = NumberFormatter()
        var format = "#,###."
        format = format.appending(String(repeating: "0", count: length))
        formatter.positiveFormat = format
        return formatter.string(from: NSNumber(value: self))!
    }
}
