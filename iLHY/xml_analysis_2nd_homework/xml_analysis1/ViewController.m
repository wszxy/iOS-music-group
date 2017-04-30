//
//  ViewController.m
//  xml_analysis1
//
//  Created by apple on 17/4/25.
//  Copyright (c) 2017年 iLHY. All rights reserved.
//

#import "ViewController.h"
#import "XMLDelegate.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
        bundle:(NSBundle *)nibBundleOrNil
{
    //调用父类实现的初始化方法
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        
    }
    return self;
}



- (void)viewDidLoad

{
    
    [super viewDidLoad];
    
    //  获取要解析的XML文档所在的URL(使用URL即可解析本地XML文档,也可解析网络XML文档)
    
    NSURL* fileURL = [[NSBundle mainBundle]  URLForResource:@"Music" withExtension:@"xml"];
    
    // 获取NSXMLParser实例对象
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:fileURL];
    
    // 创建NSXMLParser解析的委托对象
    
    parserDelegate = [[XMLDelegate alloc] init];
    
    //  为NSXMLParser指定委托对象,该委托对象就负责处理解析事件
    
    parser.delegate = parserDelegate;
    
    // 开始解析,解析结果会保存在委托对象的books属性中
    
    [parser parse];
    
}

- (IBAction)analysis:(id)sender
{
    NSMutableString* tempResult = [NSMutableString string];
    for(NSString *key in parserDelegate.resultDict){
        [tempResult appendString:key];
        [tempResult appendString:[parserDelegate.resultDict objectForKey:key]];
    }
    self.resultLabel.text = tempResult;
    NSLog(@"%@", self.resultLabel.text);
    NSLog(@"%@", parserDelegate.resultDict);
    NSLog(@"Program is running");
}

@end


