//
//  ViewController.swift
//  YJModelExtension
//
//  Created by chen on 15/11/20.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//


import Foundation

extension NSObject{
    /**字典转模型*/
    class func objectWithKeyValues(keyValues:NSDictionary)->AnyObject{
        let model = self.init()
        let properties = self.getAllProperties()
        model.setValueForProperty(properties, keyValues: keyValues)
        return model
    }
    
    /**需满足JSON是由字典转换的*/
    class func objectWithJSON(json:JSON) -> AnyObject{
        let model = self.init()
        if let keyValues = json.rawValue as? NSDictionary{
            return self.objectWithKeyValues(keyValues)
        }
        return model
    }
}

extension NSObject{
    //子类重写这个方法，对字典里的key和类的属性进行映射
    func replacedKeyFromPropertyName() ->[String:String]{
        return ["":""]
    }
    //子类重写这个方法，说明数组里存放的数据类型
    func objectClassInArray() -> [String:String]{
        return ["":""]
    }
}

extension NSObject{
    func setValueForProperty(ppt:[YJProperty]?,keyValues:NSDictionary){
        if let properties = ppt {
            for property in properties{
                if property.propertyType.isFromFoundtion{
                    if let value = keyValues[property.key]{
                        //如果数组存放的是对象
                        if property.propertyType.isArray && property.propertyType.arrayClass != nil  && value is NSArray {
                            let temp = property.propertyType.arrayClass!.objectArrayWithKeyValuesArray(value as! NSArray)
                            self.setValue(temp, forKey: property.propertyName as String)
                        }else{
                            //如果不是数组或者数组是普通数组
                            self.setValue(value, forKey: property.propertyName as String)
                        }
                        
                    }} else{
                    //2.不属于Foudation库
                    if let value = keyValues[property.key]{
                        deBugLog("\(value)")
                        
                        if value is NSDictionary{
                            let subClass = property.propertyType.typeClass?.objectWithKeyValues(value as! NSDictionary)
                            //为model类赋值
                            self.setValue(subClass, forKey: property.propertyName as String)
                        }
                    }
                }
                
            }
        }
    }
    //把一个字典数组转成一个模型数组 -处理字典数组转模型数组的时候用
    class func objectArrayWithKeyValuesArray(array:NSArray) -> [AnyObject]{
        var temp = Array<AnyObject>()
        let properties = self.getAllProperties()
        for(var i = 0;i < array.count;i++){
            let keyValues = array[i] as? NSDictionary
            if (keyValues != nil){
                let model = self.init()
                //为每个model赋值
                model.setValueForProperty(properties, keyValues: keyValues!)
                temp.append(model)
            }
        }
        return temp
    }
}


extension NSObject{
    //获取所有的属性
    class func getAllProperties()-> [YJProperty]?{
        if let className =  NSString(CString: class_getName(self), encoding: NSUTF8StringEncoding) {
            if className.isEqualToString("NSObject"){
                return nil//递归结束的条件
            }
        }else{
            return nil
        }
        //初始化数组
        var propertiesArray = [YJProperty]()
        var outCount:UInt32 = 0
        let properties = class_copyPropertyList(self.classForCoder(),&outCount)
        //获取父类属性
        if let superclassType = self.superclass() as? NSObject.Type{
            if let superM = superclassType.getAllProperties() {
                //加上父类的属性
                propertiesArray = propertiesArray + superM
            }
        }
        //获取自己的属性
        //1.检查是否有需要映射的内容
        let replaceDic = self.init().replacedKeyFromPropertyName()
        for var i = 0;i < Int(outCount);i++ {
            let property = YJProperty(property: properties[i])
            //判断是否有映射关系
            if let retKey = replaceDic[property.propertyName as String]{
                property.key = retKey
                deBugLog("\(property.propertyName)映射为\(property.key)")
            }
            if  property.propertyType.isArray {
                let objectArray = self.init().objectClassInArray()
                //判断数组里是自定义的类型
                if let objectName = objectArray[property.propertyName as String]{
                    property.propertyType.arrayClass = swiftClassFromString(objectName)
                }
            }
            deBugLog("\(property.propertyName)")
            propertiesArray.append(property)
        }
        return propertiesArray
    }
}



//存放属性的类
class YJProperty{
    // let 属性名 : 类型名
    // let name  : String
    var property:objc_property_t
    //属性名
    var propertyName:NSString{
        return NSString(CString: property_getName(self.property),
            encoding: NSUTF8StringEncoding)!
    }
    var propertyType:YJType!
    //映射的key
    var key:String!
    init(property:objc_property_t){
        self.property = property
        self.key = self.propertyName as String
        self.propertyType = YJType(className: getPropertyAttributes(self.property)!)
    }
}

class YJType {
    var className:NSString
    var typeClass:AnyClass?
    var isFromFoundtion:Bool = true
    var isArray:Bool = false
    var arrayClass:AnyClass?
    init(className:NSString){
        self.className = className
        deBugLog("\(self.className)")
        if self.className.hasPrefix("NS"){
            self.isFromFoundtion = true
            self.typeClass = NSClassFromString(self.className as String)
            if self.className.hasPrefix("NSArray"){
                self.isArray = true
            }
        }else{
            self.isFromFoundtion = false
            self.typeClass = swiftClassFromString(self.className as String)
            deBugLog("\(self.typeClass)")
        }
        
    }
}



// let 属性名 : 类型名
// let name  : String
extension NSObject{
    //得到属性名
    func getPropertyName(propertyT:objc_property_t) -> NSString?{
        let propertyName =  NSString(CString: property_getName(propertyT), encoding: NSUTF8StringEncoding)
        return propertyName
    }
    /**得到当前的类 ``swift_字典转模型修改.Family`` */
    class func getNameOfClass()-> NSString?{
        return NSString(CString: class_getName(self), encoding: NSUTF8StringEncoding)
    }
}
//得到类名
func getPropertyAttributes(propertyT:objc_property_t) -> NSString?{
    let code = NSString(CString: property_getAttributes(propertyT), encoding: NSUTF8StringEncoding)
    return code?.analyzePropertyAttributes()
}

func swiftClassFromString(className: String) -> AnyClass! {
    if  let appName: String? = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String? {
        let retStr = "_TtC\(appName!.characterLength)\(appName!)\(className.characterLength)\(className)".stringByReplacingOccurrencesOfString(" ", withString: "_")
        let  cls: AnyClass? = NSClassFromString(retStr)
        assert(cls != nil, "class not found,please check className")
        return cls
    }
    return nil;
}


//分析property_getAttributes
extension NSString {
    func analyzePropertyAttributes()->NSString{
        var code = self
        code = code.componentsSeparatedByString("\"")[1]
        let bundlePath = getBundleName()
        let range = code.rangeOfString(bundlePath)
        if range.length > 0 {
            //去掉工程名字之前的内容
            code = code.substringFromIndex(range.length + range.location)
        }
        //在去掉剩下的数字
        var number:String = ""
        for char in (code as String).characters{
            if char <= "9" && char >= "0"{
                number += String(char)
            }else{
                break
            }
        }
        let numberRange = code.rangeOfString(number)
        if numberRange.length > 0{
            code = code.substringFromIndex(numberRange.length + numberRange.location)
        }
        return code
    }
}

//字符长度，中文算3个字符
extension String {
    var characterLength:Int{
        return self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    }
}

func getBundleName() -> String{
    var bundlePath = NSBundle.mainBundle().bundlePath
    bundlePath = bundlePath.componentsSeparatedByString("/").last!
    bundlePath = bundlePath.componentsSeparatedByString(".").first!
    return bundlePath.stringByReplacingOccurrencesOfString(" ", withString: "_")
}

// MARK: - Log
func deBugLog(items: String, function: Int32 = __LINE__,file:String = __FILE__) {
    //    let className = String.fromCString(strrchr(file, Int32(("/".cStringUsingEncoding(NSUTF8StringEncoding)?.first)!))+1)!
    //    print("-[\(className) \(function)]: \(items)")
}

