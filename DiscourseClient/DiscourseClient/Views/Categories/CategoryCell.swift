//
//  CategoryCell.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 20/3/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//


import UIKit

class CategoryCell: UITableViewCell {
    var viewModel: CategoryCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.textLabelText
        }
    }
}
