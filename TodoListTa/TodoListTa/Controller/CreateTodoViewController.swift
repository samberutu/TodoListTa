//
//  CreateTodoViewController.swift
//  TodoListTa
//
//  Created by Samlo Berutu on 05/05/21.
//

import UIKit
import CoreData

class CreateTodoViewController: UIViewController {
    
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var titleTodoLbl: UITextField!
    @IBOutlet weak var descTodoLbl: UITextField!
    @IBOutlet weak var alertEmptyField: UILabel!
    
    //another variable
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var delegate : CreateTodoProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpcolor()
        let formatte = DateFormatter()
        formatte.locale = Locale(identifier: "en_gb")
        formatte.dateFormat = "hh:mm"
        //txtField.
        timePeaker()
        delegate?.reloadMainpage()
    }
    
    func setUpcolor(){
        alertEmptyField.isHidden = true
        self.view.backgroundColor = UIColor.todoLisTaWhiteColor
        //time
        timeField.layer.borderWidth = 2
        timeField.layer.borderColor = UIColor.todoLisTaPinkColor.cgColor
        timeField.layer.cornerRadius = 8
        //title
        titleTodoLbl.layer.borderWidth = 2
        titleTodoLbl.layer.borderColor = UIColor.todoLisTaPinkColor.cgColor
        titleTodoLbl.layer.cornerRadius = 15
        //desc
        descTodoLbl.layer.borderWidth = 2
        descTodoLbl.layer.borderColor = UIColor.todoLisTaPinkColor.cgColor
        descTodoLbl.layer.cornerRadius = 15
        
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        print("tombol kembali")
        delegate?.reloadMainpage()
        sleep(1)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func doneBtn(_ sender: UIButton) {
        alertEmptyField.isHidden = false
        print("tombol selesai")
        //timePeaker()
        if titleTodoLbl.text == "" {
            //jangan lupa buat alert jika field kosong
            print("field kosong")
        }else{
            saveData()
            delegate?.reloadMainpage()
            sleep(1)
            dismiss(animated: false, completion: nil)
            
        }
        
        delegate?.reloadMainpage()
    }
    
    func saveData() {
        //add new person
        let newData = DataTodoList(context: self.context)
        newData.todo = titleTodoLbl.text
        newData.checkList = false
        newData.date = "tanggal"
        newData.desc = descTodoLbl.text
        newData.time = timeField.text
        
        do{
            try self.context.save()
        }catch{
            print("error to save data")
        }
    }
    
    func timePeaker(){
        let timePeaker = UIDatePicker()
        timePeaker.datePickerMode = .time
        timePeaker.addTarget(self, action: #selector(timePeakerValueAction(sender:)), for: UIControl.Event.valueChanged)
        timePeaker.frame.size = CGSize(width: 0, height: 250)
        timeField.inputView = timePeaker
    }
    
    @objc func timePeakerValueAction(sender: UIDatePicker){
        let formatte = DateFormatter()
        formatte.locale = Locale(identifier: "en_gb")
        formatte.dateFormat = "hh:mm"
        timeField.text = formatte.string(from: sender.date)
        //print(formatte.string(from: sender.date))
    }
    
}
