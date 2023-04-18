//
//  SettingsViewModel.swift
//  ArtDeFond
//
//  Created by Someone on 18.04.2023.
//

import Foundation
import Combine

final class SettingsViewModel: NSObject {
    private let settings: [SettingType] = SettingType.allCases
    @Published var settingsModels: [SettingsModel] = []
    
    private let coorinator: ProfileCoordinatorDescription
    
    init(coordinator: ProfileCoordinatorDescription) {
        self.coorinator = coordinator
        super.init()
        
        configureSettingsModels()
    }
    
    private func configureSettingsModels(){
        var settingsModels = SettingType.allCases.map { SettingsModel(title: $0.rawValue, image: $0.getImage())
        }
        self.settingsModels = settingsModels
    }
    
    func cellWasSelected(at indexPath: IndexPath) {
        let index = indexPath.row
        let selectedSetting = settings[index]
        switch selectedSetting {
        case .edit:
            break
        case .addresses:
            coorinator.goToAddresses()
        case .sales, .purchases:
            coorinator.goToOrdersScreen(with: selectedSetting)
        case .wallet:
            break
        case .deleteAccount:
            coorinator.showDeleteAccountAlert()
        case .signOut:
            coorinator.showSignOutAlert()
        }
    }
}
