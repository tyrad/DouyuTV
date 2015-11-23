//
//  YJScrollView.swift
//  OperationForLandTax
//
//  Created by chen on 15/11/5.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import Foundation
import UIKit
typealias currentPageClosure = (currentPage:Int)->Void
typealias didScrollClosure = (scrollView:UIScrollView)->Void

class YJScrollView: UIScrollView,UIScrollViewDelegate{
    var retPageClosure:currentPageClosure?
    var retScrollClosure:didScrollClosure?
    var views:Array<UIView>?
    //当前的页
    var currentPage:Int {
        return (Int)(self.contentOffset.x / self.frame.size.width)
    }

    //MAKR: public方法
    func getDisplayViews(array:Array<UIView>?) ->YJScrollView{
        self.views = array ;
        return self
    }
    func getCurrentPage(closure:currentPageClosure?) -> YJScrollView{
        retPageClosure = closure
        return self
    }
    func didScorll(didScroll:didScrollClosure?)->YJScrollView{
        retScrollClosure = didScroll
        return self
    }
    func scrollToPage(page:Int, animate:Bool){
        //判断是末页
        if page >= self.views?.count{
            return
        }
        self.setContentOffset(CGPointMake(self.width*CGFloat(page), 0), animated: animate)
        if animate  == false {
            //没有动画
            self.scrollViewDidScrollWithoutAnimation()
        }
    }
    //
    override func awakeFromNib() {
        self.delegate = self
        self.pagingEnabled = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let viewsArr = self.views {
            self.contentSize = CGSizeMake(self.width*CGFloat(viewsArr.count), self.height)
            for  view:UIView in viewsArr{
                view.removeFromSuperview()
            }
            self.loadMyView()
        }
    }
    
    
    
    //结束滚动:通过代码滚动的时候调用
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.retPageClosure?(currentPage: currentPage)
        self.loadMyView()
    }
    //无动画滚动
    private func scrollViewDidScrollWithoutAnimation(){
        self.retPageClosure?(currentPage: currentPage)
        self.loadMyView()
    }
    
    //MARK:加载当前视图的方法
   private func loadMyView(){
        if self.views?.count  == 0 {return }
        self.loadPageViewOfPage(self.currentPage)
        self.loadPageViewOfPage(self.currentPage+1)
        self.loadPageViewOfPage(self.currentPage-1)
    }
    
   private func loadPageViewOfPage(pageIndex:Int){
        let tag = 999
        if pageIndex >= 0 && pageIndex<self.views?.count{
            if self.viewWithTag(tag+pageIndex) == nil {
                let targetView:UIView = self.views![pageIndex]
                targetView.frame = CGRectMake(self.width * CGFloat(pageIndex), 0, self.width, self.height)
                targetView.tag = tag + pageIndex
                self.addSubview(targetView)
            }
        }
    }
    
    //手指驱动滑动，滑动停止
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView)
    }
    //通用
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.retScrollClosure?(scrollView:scrollView)
    }
}
