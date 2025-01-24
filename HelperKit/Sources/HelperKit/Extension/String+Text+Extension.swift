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
            public static let undo = "Отмена"//"Undo"
            public static let reset = "Сброс"//"Reset"
            public static let create = "Создать"//"Create"
            public static let cancel = "Отменить"//"Cancel"
            public static let select = "Выбрать"//"Select"
            public static let delete = "Удалить"//"Delete"
            public static let add = "Добавить"//"Add"
            public static let createFirstZikr = "Создать первый зикр"//"Create first zikr"
        }

        public enum icon {
            public static let infinity = "∞"
        }
        
        public enum alert {
            public static let createFirstZikr = "Создать ваш первый зикр"//"Create your first zikr"
            public static let createNewZikr = "Создать ваш новый зикр"//"Create your new zikr"
            public static let resetZikrCompletely = "Сбросить зикр полностью?"//"Reset this zikr completely?"
            public static let delelteZikr = "Удилть зикр"//"Delete zikr"
        }
        
        public enum textField {
            public enum placeholder {
                public static let zikrName = "Название зикра"//"Zikr name"
            }
        }
        
        public enum title {
            public static let zikrs = "Зикры"//"Zikrs"
        }
        
        public enum tab {
            public static let zikr = "Зикр"//"Zikr"
            public static let salah = "Намаз"//"Salah"
        }
    }
}
