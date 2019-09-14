//
//  ProfileViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/8/29.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileRootView: ProfileRootView!
    
    var pets: [Pet] = []
    
    let types: [String] = ["貓咪", "狗狗", "其他"]
    
    var alertNameTextField: UITextField?
    var alertTypeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileRootView.delegate = self
        
        navigationBarSetting()
        
        pets.append(Pet(name: "蘋果花", type: .cat))
        pets.append(Pet(name: "琵琶", type: .cat))
    }
    
    // 設定 navigationbar 文字顏色、按鈕
    private func navigationBarSetting() {
        self.navigationController?.navigationBar.tintColor = .darkGray
        let addPetButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addPet))
        addPetButton.image = UIImage(named: "icons-50px_add")
        self.navigationItem.rightBarButtonItem = addPetButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func alertView() {
        let controller = UIAlertController(title: "新增毛小孩", message: "請輸入毛小孩的資料", preferredStyle: .alert)
        controller.addTextField { (textField) in
            textField.placeholder = "名字"
            textField.keyboardType = UIKeyboardType.default
        }
        
        controller.addTextField {[weak self] (textField) in
            let typePicker = UIPickerView()
            typePicker.dataSource = self
            typePicker.delegate = self
            
            textField.inputView = typePicker
            self?.alertTypeTextField = textField
            textField.text = self?.types[0]
            
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            let name = controller.textFields?[0].text ?? ""
            let type = controller.textFields?[1].text ?? ""
            print("name = \(name), type = \(type)")
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
    @objc private func addPet() {
        print("添加寵物")
        alertView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func showDetailPage() {
        guard let detailViewController =
            UIStoryboard.profile.instantiateViewController(
                withIdentifier: "PetDetailPage")
                as? ProfileDetailViewController
        else {
            print("can't find ProfileDetailViewController")
            return
        }
        detailViewController.view.backgroundColor = .white
//        detailViewController.pets = pets
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       alertTypeTextField?.text = types[row]
    }
}

extension ProfileViewController: ProfileRootViewDelegate {
   
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section < pets.count {
            print("第 \(indexPath.section) 筆寵物資料")
            showDetailPage()
        } else {
            
            print("添加寵物")
            addPet()
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return pets.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
//            pets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileTableViewCell.identifier,
            for: indexPath)
            as? ProfileTableViewCell
        else {
            return UITableViewCell()
        }
        if indexPath.section < pets.count {
            if indexPath.section == 0 {
                cell.setImage(name: "IMG_1098")
            } else {
                cell.setImage(name: "IMG_8903")
            }
            cell.setText(name: pets[indexPath.section].name, gender: "♂︎", birth: "2018年1月23日")
        } else {
            cell.showAddPetLabel()
            cell.setImage(name: "icons-50px_add")
        }
        return cell
    }
}
