//
//  ViewController.swift
//  10YearChallenge
//
//  Created by Sharon on 2020/11/24.
//

import UIKit


class ViewController: UIViewController {

    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var picker: UIDatePicker!
    
    @IBOutlet weak var speedSegment: UISegmentedControl!
    
    
    var dateFormatter = DateFormatter()
    var year :String = "2010" //以年為單位，初始先給2010
    var timer: Timer?
    var timeInterval :Double = 1
    var defaultSpeed = 0 //segment index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        slider.isContinuous = false //手離開 slider 後圓點才移動到正確的位置
        let dateComponents = DateComponents(calendar: Calendar.current, year: 2010, month: 1, day: 1, hour: nil, minute: nil, second: nil)
        let date = dateComponents.date
        picker.setDate(date!, animated: true)//設定datePicker初始值
        photo.image = UIImage(named: "2010")
//        speedSegment.isHidden = true
        speedSegment.isEnabled = false
        
    }

    @IBAction func timeSlider(_ sender: UISlider) {
//        sender.value.round()//將 value 四捨五入，讓 slider 的圓點滑動到整數的位置
        
        sender.setValue(sender.value.rounded(), animated: true) //加入動畫看起來效果較好
        year = String(Int(sender.value))//要寫在setValue後面，不然調到2011時，year的值還是2010
        dateFormatter.dateFormat = "yyyy/mm/dd"//因為datePicker沒辦法只顯示年份，所以要加上月和日
        picker.setDate(dateFormatter.date(from: year + "/1/1")!, animated: true) //將日和月都固定為1/1
        photo.image = UIImage(named: year)
    }
    
    @IBAction func timePicker(_ sender: UIDatePicker) {
        dateFormatter.dateFormat = "yyyy"
        let date = sender.date
        year = dateFormatter.string(from: date) //得到年份
        slider.setValue(Float(year)!, animated: true)//讓slider同步
        photo.image = UIImage(named: year)
    }
    
    @objc func update(){
        var current = Int(year)!
        let speed = speedSegment.selectedSegmentIndex
        timeInterval  = 1.0 / Double((speed + 1))

        //先偵測segment有沒有被改變
        if speed != defaultSpeed {
            
            self.timer?.invalidate()//把計時器停掉
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        }
        defaultSpeed = speed

        if current + 1 > 2020{
            current = 2010
            photo.image = UIImage(named: String(current))
            year = String(current)
            dateFormatter.dateFormat = "yyyy/mm/dd"
            picker.setDate(dateFormatter.date(from: year + "/1/1")!, animated: true)
            slider.setValue(Float(year)!, animated: true)
//            self.timer?.invalidate()//把計時器停掉
        }else{
            current = current + 1
            year = String(current)
            photo.image = UIImage(named: String(current))
            dateFormatter.dateFormat = "yyyy/mm/dd"
            picker.setDate(dateFormatter.date(from: year + "/1/1")!, animated: true)
            slider.setValue(Float(year)!, animated: true)
        }
        
        
    }
    

    @IBAction func autoplay(_ sender: UIButton) {
        let title = sender.titleLabel!.text!
        if title.elementsEqual("自動播放"){
            speedSegment.isEnabled = true
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            sender.setTitle("停止播放", for:.normal)
            
        }else{
            speedSegment.isEnabled = false
            sender.setTitle("自動播放", for:.normal)
            self.timer?.invalidate()//把計時器停掉
        }
                
    }
    
    
     
}

