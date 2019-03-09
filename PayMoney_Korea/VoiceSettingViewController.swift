//
//  VoiceSettingViewController.swift
//  PayMoney_Korea
//
//  Created by 정다운 on 2019. 3. 10..
//  Copyright © 2019년 daunjoung. All rights reserved.
//

import UIKit
import AVFoundation

class VoiceSettingViewController: UIViewController {

    let YUNA_IDENTIFIER = "com.apple.ttsbundle.Yuna-compact"
    let YUNA_EXT_IDENTIFIER = "com.apple.ttsbundle.Yuna-premium"
    let SORA_IDENTIFIER = "com.apple.ttsbundle.Sora-compact"
    let SORA_EXT_IDENTIFIER = "com.apple.ttsbundle.Sora-premium"
    
    @IBOutlet var yunaBtn: UIButton!
    @IBOutlet var yunaExtBtn: UIButton!
    @IBOutlet var soraBtn: UIButton!
    @IBOutlet var soraExtBtn: UIButton!
    
    @IBOutlet var yunaChkImg: UIImageView!
    @IBOutlet var yunaExtChkImg: UIImageView!
    @IBOutlet var soraChkImg: UIImageView!
    @IBOutlet var soraExtChkImg: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var setVoice : String? = UserDefaults.standard.string(forKey: "ChoiceVoice")
        
        if setVoice == nil {
            UserDefaults.standard.set(YUNA_IDENTIFIER, forKey: "ChoiceVoice")
            setVoice = YUNA_IDENTIFIER
        }
        
        
        let res = AVSpeechSynthesisVoice.speechVoices().filter({ (voice:AVSpeechSynthesisVoice) -> Bool in
            if voice.identifier.contains("Yuna") {
                return true
            } else if voice.identifier.contains("Sora") {
                return true
            } else {
                return false
            }
        })
        
        let identifierList : [String] = res.map { (voice : AVSpeechSynthesisVoice) -> String in
            return voice.identifier
        }
        
        print("\(identifierList)")
        
        
        if identifierList.contains(YUNA_IDENTIFIER) {
            yunaBtn.isEnabled = true
            yunaBtn.alpha = 1
        } else {
            yunaBtn.isEnabled = false
            yunaBtn.alpha = 0.4
        }
        
        if identifierList.contains(YUNA_EXT_IDENTIFIER) {
            yunaExtBtn.isEnabled = true
            yunaExtBtn.alpha = 1
        } else {
            yunaExtBtn.isEnabled = false
            yunaExtBtn.alpha = 0.4
        }
        
        if identifierList.contains(SORA_IDENTIFIER) {
            soraBtn.isEnabled = true
            soraBtn.alpha = 1
        } else {
            soraBtn.isEnabled = false
            soraBtn.alpha = 0.4
        }
        
        if identifierList.contains(SORA_EXT_IDENTIFIER) {
            soraExtBtn.isEnabled = true
            soraExtBtn.alpha = 1
        } else {
            soraExtBtn.isEnabled = false
            soraExtBtn.alpha = 0.4
        }
        
        switch setVoice {
        case YUNA_IDENTIFIER:
            yunaChkImg.isHidden = false
        case YUNA_EXT_IDENTIFIER:
            yunaExtChkImg.isHidden = false
        case SORA_IDENTIFIER:
            soraChkImg.isHidden = false
        case SORA_EXT_IDENTIFIER:
            soraExtChkImg.isHidden = false
        default:
            print("Invalid voice identifier")
        }
        
        
    }
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickYuna(_ sender: Any) {
        UserDefaults.standard.set(YUNA_IDENTIFIER, forKey: "ChoiceVoice")
        setRemoveCheckImg()
        yunaChkImg.isHidden = false
    }
    
    @IBAction func onClickYunaExt(_ sender: Any) {
    UserDefaults.standard.set(YUNA_EXT_IDENTIFIER, forKey: "ChoiceVoice")
        setRemoveCheckImg()
        yunaExtChkImg.isHidden = false
    }
    
    @IBAction func onClickSora(_ sender: Any) {
        UserDefaults.standard.set(SORA_IDENTIFIER, forKey: "ChoiceVoice")
        setRemoveCheckImg()
        soraChkImg.isHidden = false
    }
    
    @IBAction func onClickSoraExt(_ sender: Any) {
        UserDefaults.standard.set(SORA_EXT_IDENTIFIER, forKey: "ChoiceVoice")
        setRemoveCheckImg()
        soraExtChkImg.isHidden = false
    }
    
    func setRemoveCheckImg() {
        yunaChkImg.isHidden = true
        yunaExtChkImg.isHidden = true
        soraChkImg.isHidden = true
        soraExtChkImg.isHidden = true
        
    }
}
