//
//  SpeedLog.swift
//  Pods
//
//  Created by Kostiantyn Koval on 08/07/15.
//
//

import Foundation

typealias SLog = SpeedLog

///LogMode type. Specify what details should be included to the log
public struct LogMode : OptionSet {

  public let rawValue: UInt
  public init(rawValue: UInt)  { self.rawValue = rawValue }

  //MARK:- Options
  public static let None     = LogMode(rawValue: 0)
  public static let FileName = LogMode(rawValue: 1 << 0)
  public static let FuncName = LogMode(rawValue: 1 << 1)
  public static let Line     = LogMode(rawValue: 1 << 2)
  public static let Date     = LogMode(rawValue: 1 << 3)

  /// AllOptions - Enable all options, [FileName, FuncName, Line]
  public static let AllOptions: LogMode = [Date, FileName, FuncName, Line]
  public static let FullCodeLocation: LogMode = [FileName, FuncName, Line]
}


///SpeedLog Type
public struct SpeedLog {
  /// Log Mode
  public static var mode: LogMode = .None

  /**
   print items to the console

   - parameter items:      items to print
   - parameter separator:  separator between items. Default is space" "
   - parameter terminator: a character inserted at the end of output.
   */

  public static func print(_ items: Any..., separator: String = " ", terminator: String = "\n", _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    #if !DISABLE_LOG
      let prefix = modePrefix(Date(), file: file, function: function, line: line)
      let stringItem = items.map {"\($0)"} .joined(separator: separator)
      Swift.print("\(prefix)\(stringItem)", terminator: terminator)
    #endif
  }
}

extension SpeedLog {

  /// Create an output string for the currect log Mode
  static func modePrefix(_ date: Date, file: String, function: String, line: Int) -> String {
    var result: String = ""
    if mode.contains(.Date) {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS "

      let s = formatter.string(from: date)
      result += s
    }
    if mode.contains(.FileName) {
      let filename = file.lastPathComponent.stringByDeletingPathExtension
      result += "\(filename)."
    }
    if mode.contains(.FuncName) {
      result += "\(function)"
    }
    if mode.contains(.Line) {
      result += "[\(line)]"
    }

    if !result.isEmpty {
      result = result.trimmingCharacters(in: CharacterSet.whitespaces)
      result += ": "
    }

    return result
  }
}

/// String syntax sugar extension
extension String {
    var ns: NSString {
        return self as NSString
    }
    var lastPathComponent: String {
        return ns.lastPathComponent
    }
    var stringByDeletingPathExtension: String {
        return ns.deletingPathExtension
    }
}
