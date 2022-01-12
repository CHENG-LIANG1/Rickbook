//
//  SettingsViewController.swift
//  Rick-diculous
//
//  Created by 梁程 on 2021/11/16.
//

import UIKit
import SnapKit
import FittedSheets

class SettingsViewController: UIViewController {
    
    let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "icon")
        Tools.setWidth(iv, 300)
        Tools.setHeight(iv, 300)
        return iv
    }()

    
    let shareButton: UIButton = {
        let btn = UIButton()
        Tools.setWidth(btn, 300)
        Tools.setHeight(btn, 60)
        btn.backgroundColor = K.rmPurple
        btn.layer.cornerRadius = 15
        btn.setTitle("Share Us", for: .normal)
        btn.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 25, weight: .bold)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    let aboutButton: UIButton = {
        let btn = UIButton()
        Tools.setWidth(btn, 300)
        Tools.setHeight(btn, 60)
        btn.backgroundColor = K.rmPurple
        btn.layer.cornerRadius = 15
        btn.setTitle("About Us", for: .normal)
        btn.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 25, weight: .bold)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    @objc func shareAction(sender: UIButton){
        sender.showAnimation {
            
            let gen = UIImpactFeedbackGenerator(style: .heavy)
            gen.impactOccurred()
            let text = "Rickbook"
            
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            

            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
            
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    @objc func aboutAction(sender: UIButton){
        sender.showAnimation {
//            let vib = UINotificationFeedbackGenerator()
//            vib.notificationOccurred(.warning)
//
            let gen = UIImpactFeedbackGenerator(style: .heavy)
            gen.impactOccurred()
            
            let vc = AboutViewController()

            vc.modalPresentationStyle = .overCurrentContext
            self.tabBarController?.present(vc, animated: false, completion: nil)

            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.presentingViewController?.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.presentingViewController?.tabBarController?.tabBar.isHidden = false

        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "Settings"
        
        shareButton.addTarget(self, action: #selector(shareAction(sender:)), for: .touchUpInside)
        view.addSubview(shareButton)
        shareButton.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(100)
            make.centerX.equalTo(view)
        }
        
        aboutButton.addTarget(self, action: #selector(aboutAction(sender:)), for: .touchUpInside)
        view.addSubview(aboutButton)
        aboutButton.snp.makeConstraints { make  in
            make.top.equalTo(shareButton.snp_bottomMargin).offset(30)
            make.centerX.equalTo(view)
        }
    }
    
}
