//
//  String+Text+Extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 18.06.2024.
//

import Foundation

extension String {
    enum text {
        enum button {
            static let undo = "Отмена"
            static let reset = "Сброс"
            static let create = "Создать"
            static let yes = "Да"
            static let no = "Нет"
        }

        enum icon {
            static let infinity = "∞"
        }
        
        enum alert {
            static let resetZikrCompletely = "Сбросить зикр полностью?"
        }
        
        enum title {
            static let zikrs = "Зикры"
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
        
        enum zikrCreation {
            static let title = "Создайте зикр"
            
            enum nameSection {
                static let header = "Название зикра"
                static let footer = "Имя зикра не должно совподать с уже существующими"
                static let placeholder = "Название зикра"
            }
            
            enum periodSection {
                static let title = "Периодичность зикра"
                static let footer = "Зикр будет сбрасываться в ноль в начале каждого выбранного периода. Ежедневно, еженедельно и т.д."
            }
        }
    }
}
