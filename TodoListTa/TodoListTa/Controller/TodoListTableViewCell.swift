//
//  TodoListTableViewCell.swift
//  TodoListTa
//
//  Created by Samlo Berutu on 01/05/21.
//

import UIKit
import CoreData

class TodoListTableViewCell: UITableViewCell {
    

    @IBOutlet weak var taskLbl: UILabel!
    @IBOutlet weak var openDescOutlet: UIButton!
    @IBOutlet weak var checkOutlet: UIButton!
    @IBOutlet weak var uiViewInTableCell: UIView!
    @IBOutlet weak var descView: UIView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var clockImg: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    //@IBOutlet weak var cellContent: UIView!
    
    
    //another var
    let chevronUp = UIImage(systemName: "chevron.up")
    let chevronDown = UIImage(systemName: "chevron.down")
    var delegate : CreateTodoProtocol?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupColor()
    }
    
    func setupColor() {
        taskLbl.tintColor = UIColor.todoLisTaBlackColor
        checkOutlet.tintColor = UIColor.todoLisTaPinkColor
        openDescOutlet.tintColor = UIColor.todoLisTaDarkGrayColor
        uiViewInTableCell.backgroundColor = UIColor.todoLisTaWhiteColor
        descView.backgroundColor = UIColor.todoLisTaFreshGrayColor.withAlphaComponent(0.25)
        clockImg.tintColor = UIColor.todoLisTaGrayColor
        timeLbl.textColor = UIColor.todoLisTaGrayColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func openDescBtn(_ sender: UIButton) {
        //let image = UIImage(systemName: "chevron.down")
        if sender.currentImage == chevronUp{
            openDescOutlet.setImage(chevronDown, for: .normal)
            print("sekarang down")
            descView.isHidden = true
        }else{
            openDescOutlet.setImage(chevronUp, for: .normal)
            print("sekarang Up")
            descView.isHidden = false
        }
        delegate?.reloadMainpage()
    }
    
    @IBAction func checkListBtn(_ sender: UIButton) {
        if sender.currentImage == UIImage(systemName: "circle"){
            checkOutlet.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            checkOutlet.tintColor = UIColor.todoLisTaDarkGrayColor
            taskLbl.textColor = UIColor.todoLisTaDarkGrayColor
            //pengen strikeThrought text tapi belum bisa
            
        }
        
    }
    
    
    
}
