//
//  ViewController.swift
//  SilicaGelEcoFan
//
//  Created by Nam on 2024/07/03.

//  *** Ver Update Log ***

//  1.0 Ver - Initial Version released(2024/07/03)
//


import UIKit

class ViewController: UIViewController {

    @IBOutlet var fanImgView: UIImageView!
    @IBOutlet var lblState: UILabel!
    @IBOutlet var lblFanTitle: UILabel!
    @IBOutlet var lblApexMode: UILabel!
    
    let MAX_FAN_NUM = 2
    var fanArr = [UIImage?]()
    var fanImgFile = ["fan.png","ultFan.png"]   // 팬 이미지 저장
    var isFanOn = false // 선풍기 전원 온오프 여부
    var isApexOn = false    // Apex 모드 온오프 여부
    var fanSpeed = 1.5  // 처음 켰을 때 팬 속도


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .darkGray
        for i in 0 ..< MAX_FAN_NUM{ //  배열에 이미지 저장
            let image = UIImage(named: fanImgFile[i])
            fanArr.append(image)
        }
        lblState.text = "정지"
        fanImgView.image = fanArr[0]    // 정지된 이미지 띄움
    }
    
    //  선풍기 스위치
    @IBAction func swOnOff(_ sender: UISwitch) {
        if sender.isOn{
            isFanOn = true
            lblState.text = "가동"
            fanSpin()
        } else {
            isFanOn = false
            fanStop()
            lblState.text = "정지"
        }
        
    }
    //  Apex 모드 스위치
    @IBAction func swApexMode(_ sender: UISwitch) {
        if sender.isOn {
            view.backgroundColor = .systemIndigo
            fanImgView.image = fanArr[1]
            lblFanTitle.textColor = .yellow
            lblApexMode.textColor = .yellow
        } else {
            view.backgroundColor = .darkGray
            fanImgView.image = fanArr[0]
            lblFanTitle.textColor = .secondarySystemBackground
            lblApexMode.textColor = .systemPink
        }
    }
    
    // 약풍 버튼
    @IBAction func btnSlowWind(_ sender: UIButton) {
        if isFanOn {
            fanImgView.transform = .identity
            fanSpeed = 1.5
            fanSpin()
            lblState.text = "약풍"
        }
        
    }
    // 중풍 버튼
    @IBAction func btnMiddleWind(_ sender: UIButton) {
        if isFanOn {
            fanImgView.transform = .identity
            fanSpeed = 0.7
            fanSpin()
            lblState.text = "중풍"
        }
        
    }
    //  강풍 버튼
    @IBAction func btnStrongWind(_ sender: UIButton) {
        if isFanOn {
            fanImgView.transform = .identity
            fanSpeed = 0.3
            fanSpin()
            lblState.text = "강풍"
        }
        
    }
    //  회전 및 정지 함수
    func fanSpin() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = CGFloat.pi * 2
        animation.duration = fanSpeed
        animation.repeatCount = .infinity
        fanImgView.layer.add(animation, forKey: "rotation")
    }
    
    func fanStop() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = CGFloat.pi * 0  // 정지하는 경우는 회전각을 0으로 설정해 멈추게 보이게 함
        animation.duration = fanSpeed
        animation.repeatCount = 0
        fanImgView.layer.add(animation, forKey: "rotation")
        fanImgView.transform = .identity    // 애니메이션 초기화
    }
    
}



