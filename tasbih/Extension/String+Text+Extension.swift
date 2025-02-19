//
//  String+Text+Extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 18.06.2024.
//

import Foundation

extension String {
    enum text {
        static let empty = ""
        
        enum button {
            static let undo = "Отмена"//"Undo"
            static let reset = "Сброс"//"Reset"
            static let create = "Создать"//"Create"
            static let cancel = "Отменить"//"Cancel"
            static let select = "Выбрать"//"Select"
            static let delete = "Удалить"//"Delete"
            static let add = "Добавить"//"Add"
            static let yes = "Да"//"Yes"
            static let no = "Нет"//"No"
            static let createFirstZikr = "Создать первый зикр"//"Create first zikr"
        }

        enum icon {
            static let infinity = "∞"
        }
        
        enum alert {
            static let createFirstZikr = "Создайте ваш первый зикр"//"Create your first zikr"
            static let createNewZikr = "Создайте ваш новый зикр"//"Create your new zikr"
            static let resetZikrCompletely = "Сбросить зикр полностью?"//"Reset this zikr completely?"
            static let delelteZikr = "Удилть зикр"//"Delete zikr"
        }
        
        enum textField {
            enum placeholder {
                static let zikrName = "Название зикра"//"Zikr name"
            }
        }
        
        enum title {
            static let zikrs = "Зикры"//"Zikrs"
        }
        
        enum tab {
            static let zikr = "Зикр"//"Zikr"
            static let salah = "Намаз"//"Salah"
        }
        
        enum info {
            static let zikrsHeader = "Управляйте своими зикрами. Выбирайте активный. Создавайте и удаляйте, отслеживайте прогресс."
        }
        
        enum intro {
            static let appName = "Tasbih App"
            static let welcome = "السلام عليكم"
            static let description = "7:205\n\"Поминай Аллаха с покорностью и страхом\nпро себя и не громко\nпо утрам и перед закатом\nи не будь одним из беспечных невежд.\""
            static let startButtonTitle = "Создать зикр"
        }
    }
}
