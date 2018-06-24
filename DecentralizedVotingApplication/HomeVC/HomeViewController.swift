//
//  HomeViewController.swift
//  DecentralizedVotingApplication
//
//  Created by Hoang Quan Tran on 4/10/18.
//  Copyright © 2018 Hoang Quan Tran. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var classTableView: UITableView!
    var user: String!
    var userInfor: User!
    var lissOfCourses = [NSManagedObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        classTableView.tableFooterView = UIView(frame: .zero )
        classTableView.delegate = self
        classTableView.dataSource = self
        let nibName = UINib(nibName: "ClassTableViewCell", bundle: nil)
        classTableView.register(nibName, forCellReuseIdentifier: "classCell")
        //        self.navigationController?.navigationBar.isHidden = false
        //        self.title = "Home"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    convenience init(user: String) {
        self.init()
        self.user = user
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lissOfCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  classTableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath) as! ClassTableViewCell
        cell.frame = UIEdgeInsetsInsetRect(cell.frame, UIEdgeInsetsMake(10, 10, 50, 10))
        let item = lissOfCourses[indexPath.row]
        cell.classNameLabel.text = item.value(forKey: "nameOfCourse") as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let lessonViewControlelr = LessonViewController(user: "LessonVC")
            lessonViewControlelr.courseName = lissOfCourses[indexPath.row].value(forKey: "nameOfCourse") as! String
            self.navigationController?.pushViewController(lessonViewControlelr, animated: true)
    }
    @IBAction func addCourseBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "New Course",
                                      message: "Add a new course",
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
    
    @IBAction func slideMenuAction(_ sender: Any) {
        let userInformationVC = UserInformationVC(user: userInfor)
        userInformationVC.modalPresentationStyle = .overFullScreen
        self.present(userInformationVC, animated: false, completion: nil)
    }
    func save(_ itemName: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Course", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(itemName, forKey: "nameOfCourse")
        
        do {
            try managedContext.save()
            lissOfCourses.append(item)
        } catch {
            print("Error to save")
        }
    }
    
    func setUpView(){
        self.view.backgroundColor = DVAColor.backgrColor
        classLabel.text = "Courses(\(lissOfCourses.count))"
        self.classTableView.reloadData()
    }
    
}


