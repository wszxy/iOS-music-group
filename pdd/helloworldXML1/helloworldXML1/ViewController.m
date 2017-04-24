//
//  ViewController.m
//  helloworldXML
//
//  Created by pdd on 2017/4/20.
//  Copyright © 2017年 BNR. All rights reserved.
//

#import "ViewController.h"
#import"Music.h"

@interface ViewController ()<NSXMLParserDelegate>



@property(nonatomic,retain)NSMutableArray *partlist,*key,*time,*clef,*pitch,*musicArray;

@property(nonatomic,retain)NSString *string;

@property(nonatomic,retain)Music *music;

@property (weak, nonatomic) IBOutlet UILabel *showparsemessage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)parserWithSax:(id)sender {
    
  NSString *filePath=[[NSBundle mainBundle]pathForResource:@"helloworld"
                                                    ofType:@"xml"];
    
    NSURL *url=[[NSURL alloc]initFileURLWithPath:filePath];
    
    NSXMLParser *parser=[[NSXMLParser alloc]initWithContentsOfURL:url ];
    
    parser.delegate=self;
    
    [parser parse];
    
    self.partlist=[NSMutableArray arrayWithCapacity:10];
    
    [_partlist addObject:self.music.partname];
    
    self.key=[NSMutableArray arrayWithCapacity:10];
    
    [_key addObject:self.music.fifths];
    
    self.time=[NSMutableArray arrayWithCapacity:10];
    
    [_time addObject:self.music.beats];
    [_time addObject:self.music.beattype];
    
    self.clef=[NSMutableArray arrayWithCapacity:10];
    
    [_clef addObject:self.music.sign];
    [_clef addObject:self.music.line];
    
    self.pitch=[NSMutableArray arrayWithCapacity:10];
    
    [_pitch addObject:self.music.step];
    [_pitch addObject:self.music.octave];
    
    self.musicArray=[NSMutableArray arrayWithCapacity:10];
    
    [_musicArray addObject:_partlist];
    [_musicArray addObject:_key];
    [_musicArray addObject:_time];
    [_musicArray addObject:_clef];
    [_musicArray addObject:_pitch];

    
    _showparsemessage.numberOfLines=12;
    
    NSString *string1;
    string1=[NSString stringWithFormat:@"helloworld.xml文件解析内容:\n 音调升降%@\n %@分音符每节拍\n 每小节%@拍\n 吉他%@谱\n 音组起始于第%@组\n 音调为标准音：%@\n 所在音组为第%@组\n 延音值 %@\n 音符为 %@\n",_music.fifths,_music.beats,_music.beattype,_music.sign,_music.line,_music.step,_music.octave,_music.duration,_music.type];
    
    
    self.showparsemessage.text=string1;
             
             
             
    
    
}

#pragma mark -NSXMLParserDelegate

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"开始解析文档");
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"已经结束解析文档");
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:( NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:( NSDictionary<NSString *,NSString *> *)attributeDict
{
    NSLog(@"遇到开始标签:%@",elementName);
    if([elementName isEqualToString:@"score-partwise"]){
    self.music=[[Music alloc]init];
    }
    if([elementName isEqualToString:@"score-partwise"])
    {
        NSLog(@"开始解析本音乐");
    }else if([elementName isEqualToString:@"part-list"]){
    NSLog(@"乐谱的MIDI设置");
    }else if([elementName isEqualToString:@"part id='p1'"]){
        NSLog(@"乐谱的信息块设置");
    }else if([elementName isEqualToString:@"key"]){
        NSLog(@"音调升降设置");
    }else if([elementName isEqualToString:@"time"]){
        NSLog(@"节拍时间设置");
    }else if([elementName isEqualToString:@"clef"]){
        NSLog(@"乐谱格式设置");
    }else if([elementName isEqualToString:@"pitch"]){
        NSLog(@"音调设置");
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:( NSString *)qName
{
    NSLog(@"遇到结束标签：%@",qName);
    
    if([elementName isEqualToString:@"part-name"]){
        self.music.partname=_string;
    }else if([elementName isEqualToString:@"divisions"]){
        _music.divisions=_string;
    }else if([elementName isEqualToString:@"fifths"]){
        _music.fifths=_string;
    }else if([elementName isEqualToString:@"beats"]){
        _music.beats=_string;
    }else if ([elementName isEqualToString:@"beat-type"]){
        _music.beattype=_string;
    }else if ([elementName isEqualToString:@"sign"]){
        _music.sign=_string;
    }else if ([elementName isEqualToString:@"line"]){
        _music.line=_string;
    }else if([elementName isEqualToString:@"step"]){
        _music.step=_string;
    }else if([elementName isEqualToString:@"octave"]){
        _music.octave=_string;
    }else if([elementName isEqualToString:@"duration"]){
        _music.duration=_string;
    }else if([elementName isEqualToString:@"type"]){
        _music.type=_string;
    }

    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"遇到内容：%@",string);
    _string=string;
}

@end
