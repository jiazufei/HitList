//
//  TableViewController.swift
//  HitList
//
//  Created by CaoFei on 15/6/17.
//  Copyright (c) 2015年 CaoFei. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    @IBAction func addName1(sender: AnyObject) {
        
        var alert = UIAlertController(title: "添加新姓名", message: "请输入名字", preferredStyle: UIAlertControllerStyle.Alert)
        let saveAction = UIAlertAction(title: "保存", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) ->
            Void in
            let textfield = alert.textFields![0] as! UITextField

            self.saveName(textfield.text)
       
            let indexPath = NSIndexPath(forRow: (self.people.count - 1), inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        alert.addTextFieldWithConfigurationHandler { (textfield:UITextField!) -> Void in
            
        }
        
        self.presentViewController(alert, animated: true) { () -> Void in
            
        }
    }
    func saveName(text:String){
        //1 取得总代理和托管对象内容总管
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedObjectContext = appDelegate.managedObjectContext
        
        //2 建立一个entity
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext!)
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        
        //3 保存文本框中的值到 person
        person.setValue(text, forKey: "name")
        
        //4 保存entity到托管对象内容总管中
        var error:NSError?
        if !managedObjectContext!.save(&error){
            println("无法保存\(error),\(error!.userInfo)")
        }
        
        //5 保存到数组中，更新UI
        people.append(person)
        
    }
    
    //保存姓名数组
    var names = [String]()
    
    //core data 对象
    var people = [NSManagedObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "姓名列表"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //1 取得总代理和托管对象内容总管
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedObjectContext = appDelegate.managedObjectContext
        
        //2 建立一个获取请求
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        //3 执行请求
        var error:NSError?
        let fetchedResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]?
        if let results = fetchedResults {
            people = results
            self.tableView.reloadData()
            println(people)
        }else{
            println("无法获取\(error),\(error!.userInfo)")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return people.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        let person = people[indexPath.row]
        cell.textLabel!.text=person.valueForKey("name") as! String?
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
