//
//  SettingsViewController.swift
//  InstaPartProfile
//
//  Created by 野澤拓己 on 2020/11/18.
//

import UIKit
import SafariServices
/*
SettingsViewController
 今回はそれぞれのcellがタップしたら処理機能を持つので
    modelにはhandler(() -> Void)を使ってあげるのがおすすめ
    -> tableView -> section1 - edit profile --> EditProfileViewController()に遷移
                             - Invited Friends
                             - Save Original Posts
                 - terms of service --> (terms or privacy or help) でそれぞれのwebページに遷移
                 - Log out --> logOutする処理(Firebaseを使う)
 */

// finalメソッドの復習

struct SettingsCellModel {
    let title : String
    let handler : (() -> Void)
}

class SettingsViewController: UIViewController {
    
    private var data = [[SettingsCellModel]]()
    
    private let tableView : UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    /// モデルの構成
    private func configureModels() {
        /*
         data = [
            セクション1 : [
                セル1 : (title: "Edit Profile", handler: (Function)),
                セル2 : (title: "Invited Friends", handler: (Function)),
                セル3 : (title: "Save Original Posts", handler: (Function)),
            ],
             セクション2 : [
                 セル1 : (title: "term", handler: (Function)),
                 セル2 : (title: "privacy", handler: (Function)),
                 セル3 : (title: "help", handler: (Function)),
             ],
             セクション3 : [
                 セル1 : (title: "Logout", handler: (Function)),
             ],
                
         ]
         */
        
        
        // section1 (edit profile, Invited Friends, )
        data.append([
            SettingsCellModel(title: "Edit Profile") { [weak self] in
                
                self?.didTapEditProfile()
                
            },
            SettingsCellModel(title: "Invited Friends") { [weak self] in
                
                self?.didTapInvitedFriends()
                
            },
            SettingsCellModel(title: "Save Original Posts") { [weak self] in
                
                self?.didTapSavePosts()
            }
            
        ])
        
        // section2 (terms of service, privacy, help)
        data.append([
            SettingsCellModel(title: "Terms of service"){ [weak self] in
                
                self?.openURL(type: .term)
                
            },
            SettingsCellModel(title: "Privacy"){ [weak self] in
                
                self?.openURL(type: .privacy)
                
            },
            SettingsCellModel(title: "Help"){ [weak self] in
                
                self?.openURL(type: .help)
                
            }
        ])
        
        // section3 LogOut
        print(data)
    }
    
    // MARK: - Section1
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        let navVC = UINavigationController(rootViewController: vc)
        
        present(navVC, animated: true)
    }
    
    private func didTapInvitedFriends() {
        
    }
    
    private func didTapSavePosts() {
        
    }
    
    // MARK: - Section2
    /*
     - 行う処理が全く同じ時(webページの遷移)等はenumを使ってタイプ作って場合分けをする
     */
    enum settingsURLType {
        case term
        case privacy
        case help
    }
    
    private func openURL(type: settingsURLType) {
        
        let urlString : String
        
        // typeで分けているときはすべての可能性を考慮に入れる
        switch type {
        case .term:
            urlString = "https://help.instagram.com/581066165581870?ref=dp"
        case .privacy:
            urlString = "https://www.instagram.com/terms/accept/?hl=ja"
        case .help:
            urlString = "https://help.instagram.com/"
        }
        
        guard  let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    // MARK: - Section3
    // ログアウト機能は後で追加する

}

extension SettingsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // sectionの数を返す
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = data[indexPath.section][indexPath.row]
        cell.textLabel?.text = model.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
    
}
