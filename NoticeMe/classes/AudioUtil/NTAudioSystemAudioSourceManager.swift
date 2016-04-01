//
//  NTAudioSystemAudioSourceManager.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/4/1.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import AVFoundation
import MediaPlayer

class NTAudioSystemAudioSourceManager: NSObject {

    private override init(){
        super.init()
    }
    static let shareInstance = NTAudioSystemAudioSourceManager()

    let systemAudioFilePath = "/System/Library/Audio/UISounds/"


    lazy private var soundIDs: [String : SystemSoundID] = Dictionary()

    func systemAudioPathList() -> [String]? {
        let pathes = NSFileManager.defaultManager().subpathsAtPath(systemAudioFilePath)
        var array = [String]()
        pathes?.enumerate().forEach({ (index: Int, element: String) in
            print(element)

            let p = systemAudioFilePath.stringByAppendingString(element)
            var flag: ObjCBool = ObjCBool(false)
            NSFileManager.defaultManager().fileExistsAtPath(p, isDirectory: &flag)
            if !flag.boolValue {
                array.append(p)
            }

        })
        return array
    }

    func soundIDWithPath(path: String) -> SystemSoundID {
        if let ID = soundIDs[path] { return ID }

        let cfurl = CFURLCreateWithString(kCFAllocatorDefault, path, nil)
        var ID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(cfurl, &ID)

        if ID != 0 { soundIDs[path] = ID }

        return ID
    }

    func systemMediaWithType(type: MPMediaType) -> MPMediaItemCollection {
        let pre = MPMediaPropertyPredicate()
        let query = MPMediaQuery(filterPredicates: [pre])

        var array: [MPMediaItem] = Array()
        query.items?.enumerate().forEach({ (index: Int, element: MPMediaItem) in
            if element.mediaType == type {
                print("\(element)")
                array.append(element)
            }
        })
        return MPMediaItemCollection(items: array)
    }

}
