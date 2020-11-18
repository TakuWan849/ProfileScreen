//
//  ProfileViewController.swift
//  InstaPartProfile
//
//  Created by 野澤拓己 on 2020/11/18.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureNavigationView()
        configureCollectionView()
        
    }

    
    private func configureCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.fullWidth/3, height: view.fullWidth/3)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .red
        
        guard let collectionView = collectionView else {
            return
        }
        
        view.addSubview(collectionView)
    }
    
    private func configureNavigationView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .done,
            target: self,
            action: #selector(didTapSettingButton)
        )
    }
    
    @objc private func didTapSettingButton() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView?.frame = view.bounds
        
    }
    
}
