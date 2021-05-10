//
//  ViewController.swift
//  TodoListTa
//
//  Created by Samlo Berutu on 22/04/21.
//

import UIKit
import CoreData

//
let dateReuseIdentifier = "dayCell"
let startingIndex = 400

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var notifBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var summeryBtn: UIButton!
    @IBOutlet weak var calendarBtn: UIButton!
    @IBOutlet weak var currentDayLbl: UILabel!
    @IBOutlet weak var tasksCountLbl: UILabel!
    @IBOutlet weak var todoListTableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tambahTaskOtlet: UIButton!
    
    //another var
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var item : [DataTodoList]?
    var itemForFilterData: [DataTodoList]?
    var hightOfCell = 200
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpColor()
        setupTableView()
        displayDate(date: Date())
        fetcDataTotableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        scrollToDate(date: Date())
        fetcDataTotableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetcDataTotableView()
    }
    
    //core data
    func fetcDataTotableView() {
        //mengambil data dari core data
        do{
            self.item = try context.fetch(DataTodoList.fetchRequest())
            
            DispatchQueue.main.async {
                self.todoListTableView.reloadData()
            }
        }
        catch{
            print("fetch data error")
        }
    }
    
    func fiterData(date : String) {
        
    }
    //savedata
    func saveData() {
        do{
            try self.context.save()
        }catch{
            print("error to save data")
        }
        
        //fetc to reload table view
        self.fetcDataTotableView()
    }
    
    func setUpColor() {
        self.view.backgroundColor = UIColor.todoLisTaWhiteColor
        notifBtn.tintColor = UIColor.todoLisTaDarkGrayColor
        searchBtn.tintColor = UIColor.todoLisTaDarkGrayColor
        summeryBtn.tintColor = UIColor.todoLisTaDarkGrayColor
        calendarBtn.tintColor = UIColor.todoLisTaDarkGrayColor
        currentDayLbl.tintColor = UIColor.todoLisTaBlackColor
        tasksCountLbl.tintColor = UIColor.todoLisTaGrayColor
        collectionView.backgroundColor = UIColor.todoLisTaWhiteColor
        collectionView.isPagingEnabled = true
        todoListTableView.backgroundColor = UIColor.todoLisTaWhiteColor
        tambahTaskOtlet.tintColor = UIColor.todoLisTaDarkGrayColor
    }
    func setupTableView() {
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
        collectionView.dataSource = self
        collectionView.delegate = self
        //todoListTableView.rowHeight = UITableViewAut
        todoListTableView.estimatedRowHeight = 100.0
        self.todoListTableView.tableFooterView = UIView()
        self.todoListTableView.estimatedRowHeight = 200
        //self.todoListTableView.
    }
    
    //testing
    let taskEx = ["jangan lupa bawa payung The Toyota Motor Corporation (Japanese: トヨタ自動車株式会社, Hepburn: Toyota Jidōsha KK, IPA: [toꜜjota], English: /tɔɪˈoʊtə/, commonly known as Toyota) is a Japanese multinational automotive manufacturer headquartered in Toyota, Aichi, Japan. It was founded by Kiichiro Toyoda and incorporated on August 28, 1937. In 2017","persiapan magang"]
    
    //TableView//TableView//TableView//TableView//TableView//TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if itemForFilterData?.count == 0{
            print("data Kosong")
        }else{
            print("ini apa dah")
        }
        return item?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = (tableView.dequeueReusableCell(withIdentifier: "listIdentifierCell", for: indexPath) as? TodoListTableViewCell)!
        
        let data = self.item![indexPath.row]
        myCell.taskLbl.text = data.todo
        myCell.descLbl.text = data.desc
        myCell.timeLbl.text = data.time
        myCell.delegate = self
        //myCell.bounds
        return myCell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(self.item![indexPath.row].date ?? "error")")
        
    }
    //CollectionView//CollectionView//CollectionView//CollectionView//CollectionView
    
    func selectCell(cell: DateCollectionViewCell) {
        if let selectedCellDate = cell.date {
            displayDate(date: selectedCellDate)
            cell.contentViewCollectionCell.layer.borderColor = UIColor.todoLisTaPinkColor.cgColor
            cell.dayOfMonthLbl.textColor = UIColor.todoLisTaPinkColor
            cell.dayOfWeekLbl.textColor = UIColor.todoLisTaPinkColor
            
        }
    }
    
    func displayDate(date: Date) {
        UsedDates.shared.displayedDate = date
        UsedDates.shared.selectdDayOfWeek = Calendar.current.component(.weekday, from: date) //so that if the selected date is Wednesday, it keeps selecting Wednesday next week
        self.currentDayLbl.text = UsedDates.shared.displayedDateString
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9999
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func scrollToDate(date: Date)
    {
        print("will scroll to today")
        let startDate = UsedDates.shared.startDate
        let cal = Calendar.current
        if let numberOfDays = cal.dateComponents([.day], from: startDate, to: date).day {
            let extraDays: Int = numberOfDays % 7 // will = 0 for Mondays, 1 for Tuesday, etc ..
            let scrolledNumberOfDays = numberOfDays - extraDays
            let firstMondayIndexPath = IndexPath(row: scrolledNumberOfDays, section: 0)
            collectionView.scrollToItem(at: firstMondayIndexPath, at: .left , animated: false)
        }
        displayDate(date: date)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        displayWeek()
    }
    
    func displayWeek() {
        var visibleCells = collectionView.visibleCells
        visibleCells.sort { (cell1: UICollectionViewCell, cell2: UICollectionViewCell) -> Bool in
            guard let cell1 = cell1 as? DateCollectionViewCell else {
                return false
            }
            guard let cell2 = cell2 as? DateCollectionViewCell else {
                return false
            }
            let result = cell1.date!.compare(cell2.date!)
            return result == ComparisonResult.orderedAscending
            
        }
        let middleIndex = visibleCells.count / 2
        let middleCell = visibleCells[middleIndex] as! DateCollectionViewCell
        
        let displayedDate = UsedDates.shared.getDateOfAnotherDayOfTheSameWeek(selectedDate: middleCell.date!, requiredDayOfWeek: UsedDates.shared.selectdDayOfWeek)
        displayDate(date: displayedDate)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let addedDays = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dateReuseIdentifier, for: indexPath) as! DateCollectionViewCell
        //cell.layer.borderWidth = 1
        //cell.layer.borderColor = UIColor.todoLisTaBlackColor.cgColor
        var addedDaysDateComp = DateComponents()
        addedDaysDateComp.day = addedDays//calculating the date of the given cell
        let currentCellDate = Calendar.current.date(byAdding: addedDaysDateComp , to: UsedDates.shared.startDate)
        
        if let cellDate = currentCellDate {
            cell.date = cellDate
            let dayOfMonth = Calendar.current.component(.day, from: cellDate)
            cell.dayOfMonthLbl.text = String(describing: dayOfMonth)
            let dayOfWeek = Calendar.current.component(.weekday, from: cellDate)
            cell.dayOfWeekLbl.textColor = UIColor.todoLisTaGrayColor
            cell.dayOfWeekLbl.text = String(describing: UsedDates.shared.getDayOfWeekLetterFromDayOfWeekNumber(dayOfWeekNumber: dayOfWeek))
            cell.contentViewCollectionCell.layer.cornerRadius = 30.0
            cell.contentViewCollectionCell.layer.borderWidth = 1
            cell.contentViewCollectionCell.layer.borderColor = UIColor.todoLisTaBlackColor.cgColor
            //cell.contentViewCollectionCell.frame.width = 100.0
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell {
            UsedDates.shared.displayedDate = cell.date!
            UsedDates.shared.selectdDayOfWeek = Calendar.current.component(.weekday, from: cell.date!)
            currentDayLbl.text = UsedDates.shared.displayedDateString
            print("Selected Date: \(UsedDates.shared.displayedDateString)")
            cell.contentViewCollectionCell.layer.borderWidth = 3
            cell.contentViewCollectionCell.layer.borderColor = UIColor.todoLisTaPinkColor.cgColor
            cell.dayOfMonthLbl.textColor = UIColor.todoLisTaPinkColor
            cell.dayOfWeekLbl.textColor = UIColor.todoLisTaPinkColor
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 125, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    @IBAction func testingAddData(_ sender: Any) {
        //create alert
        let alert = UIAlertController(title: "Add Person", message: "what is their name", preferredStyle: .alert)
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "add", style: .default) { (action) in
            //add data from textfield
            let textField = alert.textFields![0]
            
            //create person object
            if textField.text == ""{
                
            }
            else{
                //add new person
                let newData = DataTodoList(context: self.context)
                newData.todo = textField.text
                newData.checkList = false
                newData.date = self.currentDayLbl.text
                newData.desc = "untuk Percobaan"
                newData.time = "10:20"
                //save data
                self.saveData()
            }
            
        }
        //show button
        alert.addAction(submitButton)
        //how alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tambahTask(_ sender: UIButton) {
    }
    
    
}

extension ViewController : CreateTodoProtocol{
    func reloadMainpage() {
        print("sampai delegate")
        fetcDataTotableView()
    }
    
    
}



