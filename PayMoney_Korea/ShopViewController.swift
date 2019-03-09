//
//  ShopViewController.swift
//  PayMoney_Korea
//
//  Created by 정다운 on 2019. 3. 2..
//  Copyright © 2019년 daunjoung. All rights reserved.
//

import UIKit
import AVFoundation

class ShopViewController: UIViewController {

    
    let YUNA_IDENTIFIER = "com.apple.ttsbundle.Yuna-compact"
    let YUNA_EXT_IDENTIFIER = "com.apple.ttsbundle.Yuna-premium"
    let SORA_IDENTIFIER = "com.apple.ttsbundle.Sora-compact"
    let SORA_EXT_IDENTIFIER = "com.apple.ttsbundle.Sora-premium"
    
    @IBOutlet var moneyLabel: UILabel!
    
    @IBOutlet var payingMoneyLabel: UILabel!
    
    @IBOutlet var greatView: UIView!
    
    @IBOutlet var gameFinishView: UIView!
    var gameMode : GameMode = GameMode.Payment_Easy
    var isPlaying : Bool = false
    
    var timer = Timer()
    
    let synthesizer = AVSpeechSynthesizer()
    
    var moneyList : [(value :Int, text :String)]! = []
    var payingMoney : Int = 0 {
        didSet {
            payedMoneyCalculate()
        }
    }
    
    var selectedVoiceIdentifier : String?
    
    var needToPayMoney : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedVoiceIdentifier = UserDefaults.standard.string(forKey: "ChoiceVoice")
        setMoneyList()
        startGame()
        
        timer.invalidate()
        
        self.gameFinishView.isHidden = true
        
        
        
    }
    
    // MARK : 게임 세팅
    func startGame () {
        needToPayMoney = moneyList.first?.value ?? 0
        payingMoney = 0
        moneyLabel.text = "\(moneyList.first?.text ?? "")원"
        greatView.isHidden = true
        isPlaying = true
        playSound();
    }
    
    func finishGame () {
        if moneyList.count == 1 {
            // 마지막 이므로 다시 셔플한다.
            UserDefaults.standard.set(true, forKey: "TutorialComplete")
            setMoneyList()
        } else {
            moneyList.remove(at: 0)
        }
        isPlaying = false
        greatView.isHidden = false
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
        
    }
    
    // MARK : 돈 정보들 세팅하기
    func setMoneyList () {
        let isTutorialComplete = UserDefaults.standard.bool(forKey: "TutorialComplete")
        
        if isTutorialComplete {
            print("Already tutorial complete")
            if gameMode == GameMode.Payment_Easy {
                moneyList = moneyDataEasy.shuffled()
            
            } else if gameMode == GameMode.Payment_Normal {
                moneyList = moneyData.shuffled()
            }
        } else {
            print("Need to show Tutorial")
            moneyList = tutorialMoney
        }
        
    }
    
    func payedMoneyCalculate () {
        
        payingMoneyLabel.text = "\(payingMoney)"
        if needToPayMoney == payingMoney {
            finishGame()
        }
    }
    // MARK : TTS
    
    func playSound() {
        speakSound("\(moneyLabel.text!) 입니다.")
    }
    func speakSound(_ text: String) {
        
        let utterance : AVSpeechUtterance = AVSpeechUtterance(string: text)

        if selectedVoiceIdentifier != nil {
            utterance.voice = AVSpeechSynthesisVoice(identifier: selectedVoiceIdentifier!)
        } else {
            utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        }
        
        if gameMode == GameMode.Payment_Easy {
            utterance.rate = 0.35
            
        } else if gameMode == GameMode.Payment_Normal {
            utterance.rate = 0.5
        }
        
        synthesizer.speak(utterance)
    }
    
    // MARK : Timer
    @objc func timerAction() {
        startGame()
        timer.invalidate()
    }

    // MARK : Money 버튼들
    
    
    @IBAction func onClickReset(_ sender: Any) {
        payingMoney = 0
    }
    
    @IBAction func onClick10Won(_ sender: Any) {
        if isPlaying {
            payingMoney += 10
        }
    }
    
    @IBAction func onClick50Won(_ sender: Any) {
        if isPlaying {
            payingMoney += 50
        }
    }
    
    @IBAction func onClick100Won(_ sender: Any) {
        if isPlaying {
            payingMoney += 100
        }
    }
    
    @IBAction func onClick500Won(_ sender: Any) {
        if isPlaying {
            payingMoney += 500
        }
    }
    
    @IBAction func onClick1000Won(_ sender: Any) {
        if isPlaying {
            payingMoney += 1000
        }
    }
    
    @IBAction func onClick5000Won(_ sender: Any) {
        if isPlaying {
            payingMoney += 5000
        }
    }
    
    @IBAction func onClick10000Won(_ sender: Any) {
        if isPlaying {
            payingMoney += 10000
        }
    }
    
    @IBAction func onClick50000Won(_ sender: Any) {
        if isPlaying {
            payingMoney += 50000
        }
    }
    
    @IBAction func onClickExit(_ sender: Any) {
        self.gameFinishView.isHidden = false
    }
    
    
    @IBAction func onClickTTSSound(_ sender: Any) {
        playSound()
    }
    
    @IBAction func onClickGoBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
