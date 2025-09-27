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
            static let more = "Еще"
            static let hadj = "Хадж"
            static let namaz = "Намаз"
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
            static let zikrsHeader = "Управляйте своими зикрами, выбирайте активный, создавайте и удаляйте их, отслеживайте свой прогресс."
            static let presetsHeader = "Здесь вы найдете самые значимые зикры. Выберите тот, что вам по душе, и начните восхвалять Всевышнего."
        }
        
        enum intro {
            static let appName = "Tasbih App"
            static let welcome = "السلام عليكم"
            static let description = "7:205\n\"Поминай Аллаха с покорностью и страхом\nпро себя и не громко\nпо утрам и перед закатом\nи не будь одним из беспечных невежд.\""
            static let presetButtonTitle = "Выбрать"
            static let newButtonTitle = "Создать"
        }
        
        enum zikrCreation {
            static let title = "Создайте зикр"
            
            enum nameSection {
                static let header = "Название зикра"
                static let footer = "Имя зикра не должно совпадать с уже существующими."
                static let placeholder = "Название зикра"
            }
            
            enum periodSection {
                static let title = "Периодичность"
                static let footer = "Количество зикров будет обнуляться в начале каждого выбранного периода — ежедневно, еженедельно и так далее."
            }
        }
        
        enum presets {
            static let honorsTitle = "Достоинства"
        }
        
        enum tip {
            enum loopSize {
                static let title = "Выбор размера круга"
                static let message = "Выберите удобный для вас размер круга. Когда вы закончите круг, то ощутите более сильный виброотклик."
            }
            
            enum undo {
                static let title = "Отмена последнего действия"
                static let message = "В случае непреднамеренного нажатия, вы сможете отменить зикр."
            }
            
            enum currentLoopCount {
                static let title = "Значение круга"
                static let message = "В этом месте вы можете увидеть, сколько раз вы совершили зикр в текущем круге. После окончания круга счётчик будет сброшен на ноль."
            }
            
            enum loopsCount {
                static let title = "Количество кругов"
                static let message = "Здесь отображается количество кругов зикров."
            }
            
            enum newZikrButton {
                static let title = "Создание зикра"
                static let message = "Создайте новый зикр, чтобы начать поминать Всевышнего."
            }
            
            enum incrementZikr {
                static let title = "Увеличение количества зикра"
                static let message = "Вы можете отмечать зикры, не переходя на главный экран."
            }
        }
    }
}
