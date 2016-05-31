//
//  WaveCountDownController.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/5/22.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit

class WaveCountDownController: BaseCountDownViewController {

    var waveView: WaveView?

    override func viewDidLoad() {
        super.viewDidLoad()
        waveView = WaveView()
        waveView?.jr_y = view.jr_height
        waveView?.createWave(Colors.Wave.Color1.CGColor, waveWith: view.jr_width, height: view.jr_height, skwing: 60, amplitude: 6, speed: 10)
        waveView?.createWave(Colors.Wave.Color2.CGColor, waveWith: view.jr_width, height: view.jr_height, skwing: 60, amplitude: 6, speed: 8)
        view.addSubview(waveView!)
        NSLog("\(view)")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        waveView?.beginWave()
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        waveView?.stopWave()
    }

    override func updateCountDownProgress(progress: Double) {
        super.updateCountDownProgress(progress)
        waveView?.jr_y = view.jr_height * CGFloat(progress)
    }



}
