//
//  GCDTimer.swift
//  GCDTimer
//
//  Created by chen on 15/11/21.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import Foundation

class GCDTimer {
    
    private var _timer : dispatch_source_t?
    
    init() {
        
    }
    
    private func _createTheTimer(interval : Double, queue : dispatch_queue_t, block : (() -> Void)) -> dispatch_source_t
    {
        let timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        if (timer != nil)
        {
            dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, Int64(interval * Double(NSEC_PER_SEC))), UInt64(interval * Double(NSEC_PER_SEC)), (1 * NSEC_PER_SEC) / 10);
            dispatch_source_set_event_handler(timer, block);
            dispatch_resume(timer);
        }
        return timer;
    }
    
    
    func start(interval : Double, block : (() -> Void))
    {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        _timer = _createTheTimer(interval, queue: queue, block: block)
        
    }
    
    func stop()
    {
        if (_timer != nil) {
            dispatch_source_cancel(_timer!);
            _timer = nil;
        }
    }
}




