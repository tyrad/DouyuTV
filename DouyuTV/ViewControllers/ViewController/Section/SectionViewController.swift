//
//  SectionViewController.swift
//  DouyuTV
//
//  Created by chen on 15/11/17.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import UIKit

class SectionViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {
 
    @IBOutlet weak var collectionView: RefreshCollectionView!
    
    private var layout:UICollectionViewFlowLayout{
        let space:CGFloat = 10.0
        let layout = UICollectionViewFlowLayout() // 116 * 195
        layout.itemSize = CGSizeMake((self.view.width-4*space)/3, (self.view.width-4*space)/3/116*195)
        layout.sectionInset = UIEdgeInsetsMake(space, space-2, 0, space-2)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.first3NavigationControllerStyle()
        print(YJSectionGameDetaiList("1", page: 0))
    }
    
  
    
    override func configureViews() {
        self.collectionView.backgroundColor =  RGB(238, 238, 238)
        self.collectionView.collectionViewLayout = self.layout
        self.collectionView.delegate = self  ;
        self.collectionView.dataSource = self ;
        self.loadData()
        self.collectionView.headerRefresh { [unowned self] () -> Void in
            self.loadData()
        }
    }

    private func loadData(){
        HTTP.getSectionGame { (ret) -> Void in
            if let data = ret {
                DLog("请求成功")
                self.data = data
            }else{
                DLog("请求失败")
            }
            self.collectionView.headerEndRefresh()
        }
    }
    
    private var data:[SectionGame] = []{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(LiveRoomViewController.segueID, sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == LiveRoomViewController.segueID {
            if let indexPath = sender as? NSIndexPath{
                let  ct = segue.destinationViewController as! LiveRoomViewController
                ct.cate_id =  YJString(self.data[indexPath.row].cate_id)
                ct.gameName = YJString(self.data[indexPath.row].game_name)
            }
        }
    }
}


extension SectionViewController {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:SectionCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(SectionCollectionCell.reuseID, forIndexPath: indexPath) as! SectionCollectionCell
        let model = self.data[indexPath.row]
        cell.dataModel(model)
        return cell
    }
}


/// Cell for SectionViewController
class  SectionCollectionCell:BaseCollectionViewCell {
    static let reuseID = "SectionCollectionCell"
    func dataModel(model:SectionGame){
        self.imageView.setImageWithURL(model.game_src, placeholder: UIImage(named: "Image_column_default"))
        
        self.titile.text = "\(model.cate_id!) \(YJString(model.game_name)!)"
    }
    override func configuration() {
        self.titile.text = ""
        self.backgroundColor = UIColor.whiteColor()
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titile: UILabel!
}

























