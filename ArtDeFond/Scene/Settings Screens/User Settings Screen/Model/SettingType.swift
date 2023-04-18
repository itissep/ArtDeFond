//
//  SettingType.swift
//  ArtDeFond
//
//  Created by Someone on 18.04.2023.
//

import UIKit

enum SettingType: String, CaseIterable {
    case edit = "Редактировать профиль"
    case addresses = "Адреса доставки"
    case sales = "Мои покупки"
    case purchases = "Мои продажи"
    case wallet = "Пополнить баланс"
    case deleteAccount = "Удалить профиль"
    case signOut = "Выйти из профиля"
    
    func getImage() -> UIImage? {
        let imageName: String
        switch self {
        case .edit:
            imageName = "pencil"
        case .addresses:
            imageName = "house.fill"
        case .sales:
            imageName = "photo.artframe"
        case .purchases:
            imageName = "shippingbox.fill"
        case .wallet:
            imageName = "creditcard"
        case .deleteAccount:
            imageName = "trash.fill"
        case .signOut:
            imageName = "ipad.and.arrow.forward"
        }
        return UIImage(systemName: imageName)
    }
}
