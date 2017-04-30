//
//  XMLDelegate.h
//  xml_analysis1
//
//  Created by apple on 17/4/26.
//  Copyright (c) 2017年 iLHY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLDelegate: NSObject<NSXMLParserDelegate>

{
    
    NSMutableString* tempKey;
    
}

@property (nonatomic) NSMutableDictionary* resultDict;

@end
