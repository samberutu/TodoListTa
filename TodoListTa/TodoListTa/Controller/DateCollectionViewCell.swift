//
//  DateCollectionViewCell.swift
//  TodoListTa
//
//  Created by Samlo Berutu on 01/05/21.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dayOfWeekLbl: UILabel!
    @IBOutlet weak var dayOfMonthLbl: UILabel!
    @IBOutlet weak var contentViewCollectionCell: UIView!
    
    var date:Date?
    
    
}
