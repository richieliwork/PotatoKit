import Foundation

/// 正则表达式运用
public struct PKRegex {
    let regex: NSRegularExpression
    
    /// 初始化
    ///
    /// - Parameter pattern: 正则表达式的格式
    /// - Throws: 异常
    init(_ pattern: String) throws {
        try regex = NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    /// 是否符合某一个正则表达式
    ///
    /// - Parameter string: 正则表达式
    /// - Returns: 是否符合规则
    public func match(_ string: String) -> Bool {
        return regex.matches(in: string, options: [], range: NSMakeRange(0, string.utf16.count)).count > 0
    }
    
    /// 邮箱的正则表达式
    public static let emailRegex = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
    
    /// 手机正则表达式
    public static let mobileRegex = "^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$"
}

precedencegroup RegexOperator {
    associativity: none
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
}

/// 重写运算符 =~
infix operator =~ : RegexOperator



/// 判断字符串是否满足正则表达式
///
/// - Parameters:
///   - lhs: 需要判断的字符串
///   - rhs: 正则表达式
/// - Returns: 是否遵循正则表达式的规则
public func =~ (lhs: String, rhs: String) -> Bool {
    do {
        return try PKRegex(rhs).match(lhs)
    } catch _ {
        return false
    }
}

// MARK: - 校验的
extension String {
    
    /// 校验是否为email
    ///
    /// - Returns: 是否email
    public func isEmail() -> Bool {
        return self =~ PKRegex.emailRegex
    }
    
    /// 校验是否为手机号码
    ///
    /// - Returns: 是否为手机号码
    public func isMobile() -> Bool {
        return self =~ PKRegex.mobileRegex
    }
}

