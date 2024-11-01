//
//  String+Text+Extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 18.06.2024.
//

import Foundation

public extension String {
    enum text {
        public static let empty = ""
        
        public enum button {
            public static let undo = "Undo"
            public static let reset = "Reset"
            public static let create = "Create"
            public static let cancel = "Cancel"
            public static let select = "Select"
            public static let delete = "Delete"
            public static let add = "Add"
            public static let createFirstZikr = "Create first zikr"
        }

        public enum icon {
            public static let infinity = "∞"
        }
        
        public enum alert {
            public static let createFirstZikr = "Create your first zikr"
            public static let createNewZikr = "Create your new zikr"
            public static let resetZikrCompletely = "Reset this zikr completely?"
        }
        
        public enum textField {
            public enum placeholder {
                public static let zikrName = "Zikr name"
            }
        }
        
        public enum systemName {
            public static let plus = "plus"
            public static let plus_circle_fill = "plus.circle.fill"
            public static let trash_fill = "trash.fill"
        }
        
        public enum title {
            public static let zikrs = "Zikrs"
        }
    }
}
