import Foundation

/// 日期格式的枚举
public struct DateFormat: RawRepresentable, Equatable, Hashable {
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public var rawValue: String
    
    public typealias RawValue = String
    
    public static func ==(lhs: DateFormat, rhs: DateFormat) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    public var hashValue: Int {
        get {
            return self.rawValue.hashValue
        }
    }
    
    /// 日期
    public static let date:DateFormat = DateFormat(rawValue: "yyyy-MM-dd")
    
    /// 时间
    public static let time:DateFormat = DateFormat(rawValue: "HH:mm:ss")
    
    /// 日期时间
    public static let datetime:DateFormat = DateFormat(rawValue: "yyyy-MM-dd HH:mm:ss")
}


// MARK: - 关于日期的扩展
extension String {
    /// 转换字符串为日期
    ///
    /// - Parameter string: 日期格式
    /// - Returns: 转换的日期
    public func dateFormatter(formatter string: DateFormat = DateFormat.datetime) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = string.rawValue
        return formatter.date(from: self)
    }
}

// MARK: - 日期扩展
extension Date {
    
    /// 获取日期中的年月日时分秒
    ///
    /// - Returns: 获取信息
    public func information() -> (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        return Calendar.dateInformation(date: self)
    }
    
    /// 转换日期为制定格式
    ///
    /// - Parameter format: 格式 默认为yyyy-MM-dd hh:mm:ss
    /// - Returns: 日期转换成功的字符串
    public func dateString(formatter format:DateFormat = DateFormat.datetime) -> String?{
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
    
}


// MARK: - 日历扩展
extension Calendar {
    
    /// 获取日期信息
    ///
    /// - Parameter date: 日期
    /// - Returns: 日期信息
    public static func dateInformation(date: Date) -> (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents(in: TimeZone.current, from: date)
        return (dateComponents.year!, dateComponents.month!, dateComponents.day!, dateComponents.hour!, dateComponents.minute!, dateComponents.second!)
    }
    
    /// 追加日期 信息
    ///
    /// - Parameters:
    ///   - date: 被追加的信息
    ///   - year: 年
    ///   - month: 月
    ///   - day: 日
    ///   - hour: 时
    ///   - minute: 分
    ///   - second: 秒
    /// - Returns: 追加后的信息
    public static func dateAppending(date: Date, year: Int = 0, month: Int = 0, day: Int = 0, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        guard let dateT = Calendar.current.date(byAdding: dateComponents, to: date) else {
            return date
        }
        return dateT
    }
}

