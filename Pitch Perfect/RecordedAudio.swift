//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Lars Smit on 10/02/16.
//  Copyright © 2016 Lars Smit. All rights reserved.
//

import Foundation

class RecordedAudio {
    var filePathUrl: NSURL!
    var title: String!
    
    init(title: String, filePathUrl: NSURL!) {
        self.title       = title
        self.filePathUrl = filePathUrl
    }
}
