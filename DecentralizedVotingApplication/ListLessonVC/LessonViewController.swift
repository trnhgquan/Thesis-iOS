//
//  LessonViewController.swift
//  DecentralizedVotingApplication
//
//  Created by Hoang Quan Tran on 5/14/18.
//  Copyright © 2018 Hoang Quan Tran. All rights reserved.
//

import UIKit
import CoreData
class LessonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var lessonTableView: UITableView!
    var listOfLesson = [NSManagedObject]()
    var user: String!
    var courseName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        lessonTableView.tableFooterView = UIView(frame: .zero )
        lessonTableView.delegate = self
        lessonTableView.dataSource = self
        self.title = courseName
        let nibName = UINib(nibName: "LessonTableViewCell", bundle: nil)
        lessonTableView.register(nibName, forCellReuseIdentifier: "lessonCell")
        // Do any additional setup after loading the view.
    }

    convenience init(user: String) {
        self.init()
        self.user = user
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfLesson.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  lessonTableView.dequeueReusableCell(withIdentifier: "lessonCell", for: indexPath) as! LessonTableViewCell
        let item = listOfLesson[indexPath.row]
        cell.lessonNameLabel.text = item.value(forKey: "nameOfLesson") as! String
        return cell
    }
 
    func setUpView(){
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(addTapped))
        self.navigationItem.rightBarButtonItem = addBtn
       
        self.lessonTableView.reloadData()
        self.view.backgroundColor = DVAColor.backgrColor
        self.lessonTableView.backgroundColor = DVAColor.backgrColor
    }

    @objc func addTapped(){
        let alert = UIAlertController(title: "New Lesson",
                                      message: "Add a new lesson",
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            self.save(nameToSave)
            self.setUpView()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listQuestionViewController = ListQuestionViewController(user: "LessonVC")
//        listQuestionViewController.isTeacher = isTeacher
        listQuestionViewController.lessonName = listOfLesson[indexPath.row].value(forKey: "nameOfLesson") as! String
        self.navigationController?.pushViewController(listQuestionViewController, animated: true)
    }
    @IBAction func scanBtnAction(_ sender: UIButton) {
        print("Scan QRCode")
    }
    
    func save(_ itemName: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Lesson", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(itemName, forKey: "nameOfLesson")
        
        do {
            try managedContext.save()
            listOfLesson.append(item)
        } catch {
            print("Error to save")
        }
    }
    
    
    
}
