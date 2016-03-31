//
//  NTAudioManager.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/3/31.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import AVFoundation

enum NTAudioType {
    case AMR
    case MP3
}

class NTAudioManager : NSObject {

    static let shareInstance = NTAudioManager()
    private override init() {
        super.init()
        configureAudioSession()
    }

    /**
     配置
     */
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("configure audio session faile \(error)")
        }
    }

    typealias NTAudioPlayerWillPlayBlock     = (player: AVAudioPlayer) -> Void
    typealias NTAudioPlayerPlayingBlock  = (player: AVAudioPlayer) -> Void
    typealias NTAudioPlayerCompleteBlock = (player: AVAudioPlayer, success: Bool) -> Void

    // MARK: 成员变量
    var filePath: String!

    lazy private(set) var currentPlayers: [AVAudioPlayer] = Array()
    lazy private(set) var currentPlayingPathes: [String]  = Array()


    // MARK: 私有变量
    lazy private var players: [String : AVAudioPlayer]                        = Dictionary()
    lazy private var timers: [String : NSTimer]                               = Dictionary()
    lazy private var willPlayCallBacks: [String : NTAudioPlayerWillPlayBlock] = Dictionary()
    lazy private var playingCallBacks: [String : NTAudioPlayerPlayingBlock]   = Dictionary()
    lazy private var completeCallBacks: [String : NTAudioPlayerCompleteBlock] = Dictionary()


    /**
     播放音频
     - parameter path:     文件路径
     - parameter type:     文件类型
     - parameter willPlay: willPlay description
     - parameter playing:  playing description
     - parameter complete: complete description
     - returns: 返回播放器
     */
    func playAudioWithPath(path: String, type: NTAudioType, needStopOther: Bool, willPlay:NTAudioPlayerWillPlayBlock, playing:NTAudioPlayerPlayingBlock, complete: NTAudioPlayerCompleteBlock) -> AVAudioPlayer? {

        return nil
    }

    /**
     根据文件路径获取播放器
     - parameter filePath: 文件路径
     - returns: 如果有，返回播放器
     */
    func playerWithFilePath(filePath: String) -> AVAudioPlayer? {
        return nil
    }

    /**
     停止某个播放器
     - parameter player: player description
     */
    func stopPlayer(player: AVAudioPlayer) {

    }

    /**
     停止全部播放器
     */
    func stopAll() {

    }

    /**
     暂停所有播放器
     */
    func pauseAll() {

    }

    // MARK: 私有方法
    func playerDidPlay(timer: NSTimer) {
        guard let path = timer.userInfo?["path"] as? String else {
            return
        }

        guard let player = players[path] else {
            return
        }

        if player.playing {
            guard let block = playingCallBacks[path] else {
                return
            }
            block(player: player)
        }
        

    }

    private func path4Player(player: AVAudioPlayer) -> String? {
        var path : String?
        for (key, value) in players {
            if value == player {
                path = key
                break
            }
        }
        return path
    }

    private func createTimer4MonitoringPlayer(player: AVAudioPlayer) -> NSTimer {
        let path = path4Player(player)
        let timer = NSTimer(timeInterval: 0.1, target: self, selector: "playerDidPlay", userInfo: ["path" : path] as? AnyObject, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        return timer
    }

    private func clearResource4Path(name: String) {
        players.removeValueForKey(name)
        willPlayCallBacks.removeValueForKey(name)
        playingCallBacks.removeValueForKey(name)
        completeCallBacks.removeValueForKey(name)

        timers[name]?.invalidate()
        timers.removeValueForKey(name)
    }

}

extension NTAudioManager : AVAudioPlayerDelegate {


    func audioPlayerBeginInterruption(player: AVAudioPlayer) {
        //暂停定时器
        guard let path = path4Player(player) else {
            return
        }
        timers[path]?.invalidate()
        timers.removeValueForKey(path)
    }

    func audioPlayerEndInterruption(player: AVAudioPlayer) {
        guard let path = path4Player(player) else {
            return
        }

        let timer = createTimer4MonitoringPlayer(player)
        timers[path] = timer
        timer.fire()
    }

    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {

        guard let path = path4Player(player) else {
            return
        }

        defer {
            clearResource4Path(path)
        }

        guard let block = completeCallBacks[path] else {
            return
        }

        block(player: player, success: flag)
    }

}
