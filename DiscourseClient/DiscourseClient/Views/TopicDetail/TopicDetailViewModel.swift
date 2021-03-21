//
//  TopicDetailViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol TopicDetailCoordinatorDelegate {
    func topicDetailBackButtonTapped()
    func topicDeleted()
}

protocol TopicDetailViewDelegate {
    func topicDetailFetched()
    func errorFetchingTopicDetail()
    func errorDeletingTopicDetail()
}

class TopicDetailViewModel {
    var labelTopicIDText: String?
    var labelTopicNameText: String?
    var postsNumber: String?
    var canDeleteTopic = false

    var viewDelegate: TopicDetailViewDelegate?
    var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    let topicDetailDataManager: TopicDetailDataManager
    let topicID: Int

    init(topicID: Int, topicDetailDataManager: TopicDetailDataManager) {
        self.topicID = topicID
        self.topicDetailDataManager = topicDetailDataManager
    }

    func viewDidLoad() {
        topicDetailDataManager.fetchTopic(id: topicID) { [weak self] result in
            guard let self = self else { return}
            
            switch result {
            case .success(let topicResp):
                guard let topic = topicResp?.topic, let details = topicResp?.details else { return }
                
                self.labelTopicIDText = "\(topic.id)"
                self.labelTopicNameText = topic.title
                self.postsNumber = "\(topic.postsCount)"
                
                self.canDeleteTopic = details.canDelete ?? false
                
                self.viewDelegate?.topicDetailFetched()
                
            case .failure(_):
                self.viewDelegate?.errorFetchingTopicDetail()
            }
            
        }
    }
    
    func deleteTopic() {
        topicDetailDataManager.deleteTopic(id: topicID) { [weak self] result in
            guard let self = self else { return}
            
            switch result {
            case .success:
                self.coordinatorDelegate?.topicDeleted()
            case .failure(_):
                self.viewDelegate?.errorDeletingTopicDetail()
            }
        }
    }

    func backButtonTapped() {
        coordinatorDelegate?.topicDetailBackButtonTapped()
    }
}
