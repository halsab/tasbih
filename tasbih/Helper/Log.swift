//
//  Log.swift
//  tasbih
//
//  Created by Khalil Sabirov on 04.01.2023.
//

import Foundation

struct Log {
    private static var path: (String, String, Int) -> String = { file, function, line in
        "\((file as NSString).lastPathComponent)/\(function):\(line)"
    }
    
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "[HH:mm:ss.SSS]"
        return formatter
    }()
    
    static func debug(
        _ items: Any...,
        separator: String = " ",
        terminator: String = "\n",
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        pp: Bool = true
    ) {
        prePrint(
            label: "🛠️",
            items,
            path: path(file, function, line),
            separator: separator,
            terminator: terminator,
            printPath: pp
        )
    }
    
    static func info(
        _ items: Any...,
        separator: String = " ",
        terminator: String = "\n",
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        pp: Bool = true
    ) {
        prePrint(
            label: "ℹ️",
            items,
            path: path(file, function, line),
            separator: separator,
            terminator: terminator,
            printPath: pp
        )
    }
    
    static func error(
        _ items: Any...,
        separator: String = " ",
        terminator: String = "\n",
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        pp: Bool = true
    ) {
        prePrint(
            label: "❌",
            items,
            path: path(file, function, line),
            separator: separator,
            terminator: terminator,
            printPath: pp
        )
    }
    
    static private func prePrint(
        label: String,
        _ items: Any...,
        path: String,
        separator: String,
        terminator: String,
        printPath: Bool
    ) {
        if printPath {
            printLog(
                "//-" + label,
                dateFormatter.string(from: Date()),
                items,
                "→ " + path,
                separator: separator,
                terminator: terminator
            )
        } else {
            printLog(
                "//-" + label,
                dateFormatter.string(from: Date()),
                items,
                separator: separator,
                terminator: terminator
            )
        }
    }
    
    static private func printLog(_ items: Any..., separator: String, terminator: String) {
        #if DEBUG
        print(items, separator: separator, terminator: terminator)
        #endif
    }
}
