//
//  TopicPinnedCell.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 17/3/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import UIKit

class TopicPinnedCell: UITableViewCell, NibLoadableView, ReusableView  {

    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    private func configureUI() {
        containerView.layer.cornerRadius = 8
        titleLabel.font = UIFont.bigTitle
        subtitleLabel.font = UIFont.paragraph
    }
}
