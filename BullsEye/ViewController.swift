//
//  ViewController.swift
//  BullsEye
//
//  Created by yurongde on 2021/3/6.
//

import UIKit

class ViewController: UIViewController {
     
    var currentValue: Int = 9
    @IBOutlet var slider: UISlider!
    @IBOutlet var targetValueLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roungLabel: UILabel!
    var targetValue = 0
    var score = 0
    var round = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //initiallize the game
        setUpSlider()
        startNewGame()
        
        
    }

    @IBAction func showAlert() {
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it"
            points += 50
        } else if difference < 10 {
            title = "Pretty good"
        } else {
            title = "Not even close..."
        }
        score += points

        updateLabels()
        /*let message = "The value of the slider is: \(currentValue)" +
        "\nThe target value is: \(targetValue)"*/
        let message = "You scored \(points) points"
        let alert = UIAlertController(
            
            title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                self.startNewRound()
            })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func sliderMove(_ slider: UISlider) {
        print("The Vaule of the slide is now:\(slider.value)")
        currentValue = lroundf(slider.value)
        print(currentValue)
    }
    @IBAction func startOver() {
        startNewGame()
    }
    func startNewGame() {
        round = 0
        score = 0
        startNewRound()
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    func startNewRound() {
        targetValue = Int.random(in: 1...100)

        round += 1

        updateLabels()
        
        currentValue = 50;
        slider.value = Float(currentValue)
    }
    func updateLabels() {
        scoreLabel.text = String(score)
        targetValueLabel.text = String(targetValue)
        roungLabel.text = String(round)
    }
    func setUpSlider() {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHiglighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHiglighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizable =
            trackLeftImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        
        
    }
}

