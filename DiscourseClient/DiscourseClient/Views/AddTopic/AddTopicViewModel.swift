//
//  AddTopicViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate para comunicar aspectos relacionados con navegación
protocol AddTopicCoordinatorDelegate {
    func addTopicCancelButtonTapped()
    func topicSuccessfullyAdded()
}

/// Delegate para comunicar a la vista aspectos relacionados con UI
protocol AddTopicViewDelegate {
    func errorAddingTopic()
}

class AddTopicViewModel {
    var viewDelegate: AddTopicViewDelegate?
    var coordinatorDelegate: AddTopicCoordinatorDelegate?
    let dataManager: AddTopicDataManager
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale.current

        return formatter
    }

    init(dataManager: AddTopicDataManager) {
        self.dataManager = dataManager
    }

    func cancelButtonTapped() {
        coordinatorDelegate?.addTopicCancelButtonTapped()
    }

    func submitButtonTapped(title: String, body: String) {
        let createdAt = dateFormatter.string(from: Date())
        
        dataManager.addTopic(title: title, raw: body, createdAt: createdAt) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.coordinatorDelegate?.topicSuccessfullyAdded()
                
            case .failure(_): 
                self.viewDelegate?.errorAddingTopic()
            }
        }
    }
}
