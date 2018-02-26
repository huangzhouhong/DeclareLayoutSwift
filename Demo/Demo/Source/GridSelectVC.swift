//
//  GridSelectVC.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2017/12/17.
//  Copyright © 2017年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import ObjectiveC
import UIKit

class GridSelectVC: UITableViewController {

//    let names=["GridColumnSplitVC" , "GridMixVC","StackVC","GridNestedVC"]
    var names: [SafeAreaVC.Type] = []

    fileprivate func findAllVC() {
        var count: UInt32 = 0
        let classList = objc_copyClassList(&count)!

        for i in 0..<Int(count) {
            let cls: AnyClass = classList[i]
            if class_getSuperclass(cls) == SafeAreaVC.self {
                self.names.append(cls as! SafeAreaVC.Type)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.findAllVC()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = String(describing: names[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = self.names[indexPath.row]
        let vc = name.init()
//        if let vc = vc{
        vc.title = String(describing: names[indexPath.row])

        self.navigationController?.pushViewController(vc, animated: true)
//        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
