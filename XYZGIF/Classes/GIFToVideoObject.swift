//
//  GIFToVideoObject.swift
//  GifToVideo
//
//  Created by 张子豪 on 2018/10/19.
//  Copyright © 2018 张子豪. All rights reserved.
//

import UIKit
import Foundation
import CoreMedia
import CoreVideo
import CoreGraphics
import AVFoundation
import QuartzCore
import SwiftyGif
import ImageIO
import SHPathManager
import FileKit
import SHTManager


var CurrentGIFToVideo = GIFToVideoObject()
public class GIFToVideoObject: NSObject {
    
    var GIFURL = URL.init(string: "")
    var ToURL = URL.init(string: "")
    
    override init() {}
    
    init(GIFURL:URL,ToURL:URL) {
        self.GIFURL = GIFURL
        self.ToURL  = ToURL
    }
    
    func ShowGIF(with imgView:UIImageView,and URLx:URL)  {
        imgView.setGifFromURL(URLx)
    }
    
    func ShowGIFs(with imgViews:[UIImageView],and URLxs:[URL])  {
        
        for i in 0...imgViews.count-1{
            imgViews[i].setGifFromURL(URLxs[i])
        }
        
        
    }
    
    
    
    //成批量生成
    func createVideo(DataURL:URL,ToURL:URL? = nil,completion:@escaping ()->Void) -> Bool{
        if let data = try? Data(contentsOf: DataURL){
            if let ToURL = ToURL{
                GIFToMP4(data: data)?.convertAndExport(to: ToURL, completion: {
                    completion()
                    
                })
            }else{
                let tempUrl = userDocument + "\(SHTManager.NowString).mp4"
                GIFToMP4(data: data)?.convertAndExport(to: tempUrl.url, completion: {
                    completion()
                })
                
            }
            return true
        }else{
            return false
        }
    }
    
    
    func 转换每一帧的数组(GIF:UIImage) -> [UIImage]? {
        var 数组 = [UIImage]()
        if let urlx = Bundle.main.url(forResource: "my", withExtension: "gif"){
            if let x = CGImageSourceCreateWithURL(urlx as CFURL, nil){
                let count = CGImageSourceGetCount(x)
                for i in 0...count-1{
                    let imageRef = CGImageSourceCreateImageAtIndex(x, i, nil)
                    let image = UIImage(cgImage: imageRef!)
                    数组.append(image)
                }}}
        if 数组.count == 0{return nil}
        return 数组
    }
    
}
