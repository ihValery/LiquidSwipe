//
//  Side.swift
//  LiquidSwipe
//
//  Created by Валерий Игнатьев on 06.11.2021.
//

import SwiftUI

enum Side {
    case left
    case right
    
    ///Shape. Минимальная высота фигуры свайпа. Меняем знак в зависимости от стороны.
    var minHeight: CGFloat {
        switch self {
        case .left: return 80
        case .right: return -80
        }
    }
    
    ///ChevronView. Возвращаем имя наоборот в зависимости от стороны.
    var image: String {
        switch self {
        case .left: return "chevron.compact.right"
        case .right: return "chevron.compact.left"
        }
    }
    
    ///ChevronView. Смещение стрелок за пределы экрана.
    func offset(bool: Bool) -> CGFloat {
        switch self {
        case .left: return bool ? 10 : -10
        case .right: return bool ? -10 : 10
        }
    }
    
    ///Shape. В зависимости от стороны рисуем в начали или в конце прямоугольника.
    func width(_ width: CGFloat) -> CGFloat {
        switch self {
        case .left: return 0
        case .right: return width
        }
    }
}
