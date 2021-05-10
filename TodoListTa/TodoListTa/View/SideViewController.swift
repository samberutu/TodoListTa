//
//  SideViewController.swift
//  TodoListTa
//
//  Created by Samlo Berutu on 22/04/21.
//

import UIKit

class SideViewController: UIViewController {

    @IBOutlet var sideViewSpace: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpComponent()
        

        // Do any additional setup after loading the view.
    }
    
    private func setUpComponent(){
        sideViewSpace.backgroundColor = UIColor.todoLisTaDarkGrayColor
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2
    }

}
