//
//  SettingsViewController.swift
//  OpenLive
//
//  Created by GongYuhua on 2/20/16.
//  Copyright © 2016 Agora. All rights reserved.
//

import Cocoa

protocol SettingsVCDelegate: class {
    func settingsVC(_ settingsVC: SettingsViewController, closeWithProfile videoProfile: AgoraRtcVideoProfile)
}

class SettingsViewController: NSViewController {

    @IBOutlet weak var profilePopUpButton: NSPopUpButton!
    
    var videoProfile: AgoraRtcVideoProfile!
    var delegate: SettingsVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
        
        loadProfileItems()
    }
    
    @IBAction func doProfileChanged(_ sender: NSPopUpButton) {
        let profile = AgoraRtcVideoProfile.validProfileList()[sender.indexOfSelectedItem]
        videoProfile = profile
    }
    
    @IBAction func doConfirmClicked(_ sender: NSButton) {
        delegate?.settingsVC(self, closeWithProfile: videoProfile)
    }
}

private extension SettingsViewController {
    func loadProfileItems() {
        profilePopUpButton.addItems(withTitles: AgoraRtcVideoProfile.validProfileList().map { (res) -> String in
            return res.description()
        })
        profilePopUpButton.selectItem(withTitle: videoProfile.description())
    }
}
