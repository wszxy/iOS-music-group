//
//  XMLDelegate.m
//  xml_analysis1
//
//  Created by apple on 17/4/26.
//  Copyright (c) 2017年 iLHY. All rights reserved.
//

#import "XMLDelegate.h"

@implementation XMLDelegate

@synthesize resultDict;

- (id) init
{
    if (self = [super init]) {
        resultDict = [NSMutableDictionary dictionary];
        tempKey = [NSMutableString string];
    }
    
    return (self);
    
} // init



//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidStartDocument...");
}


//  当开始处理某个元素时触发该方法
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName

  namespaceURI:(NSString*)namespaceURI   qualifiedName:(NSString*)qName

    attributes:(NSDictionary*)attributesDict

{
    
    NSLog(@"开始处理元素 %@",  elementName);
    NSLog(@"开始处理字典值 %@",  attributesDict);
    [tempKey appendString: elementName];
    NSLog(@"开始tempKey:%@", tempKey);
    for(NSString* key in attributesDict){
        [tempKey appendString:key];
        [tempKey appendString:[attributesDict objectForKey:key]];
    }
}

// 当开始处理字符串内容时触发该方法

- (void) parser:(NSXMLParser*)parser foundCharacters:(NSString *)string

{
    
    NSLog(@"正在处理字符串内容: %@",  string);
    NSLog(@"正在处理tempKey:%@", tempKey);
    
    // 如果当前的字符串值不为nil,则保存当前正在处理的元素的值
    
    //确定叶节点

    [resultDict setObject:string forKey:tempKey];

}

// 当处理某个元素结束时触发该方法

- (void) parser:(NSXMLParser*)parser didEndElement:(NSString*)elementName

   namespaceURI:(NSString*)namespaceURI  qualifiedName:(NSString*)qName

{
    
    // 如果处理根元素结束,则表明XML文档处理完成
    NSLog(@"结束处理元素 %@",  elementName);
    NSUInteger index = [tempKey length] - [elementName length];
    [tempKey deleteCharactersInRange:NSMakeRange(index, [elementName length])];
    NSLog(@"结束tempKey：%@",  tempKey);
}

//解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidEndDocument...");
}

@end

