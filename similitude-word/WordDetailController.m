//
//  WordDetail.m
//  similitude-word
//
//  Created by vzyw on 16/2/5.
//  Copyright © 2016年 vzyw. All rights reserved.
//

#import "WordDetailController.h"
#import "CellController.h"
#import "AddWordController.h"
#import "Button.h"
@interface WordDetailController ()
@property (weak,nonatomic) IBOutlet UIView *wordView;

@property (weak, nonatomic) IBOutlet UITableView *wordList;

@property (weak, nonatomic) IBOutlet UILabel *wordName;

@property (weak, nonatomic) IBOutlet Button *pr_uk_mp3;
@property (weak, nonatomic) IBOutlet Button *pr_us_mp3;
@property (weak, nonatomic) IBOutlet UILabel *definitions;
@property (weak, nonatomic) IBOutlet UIButton *addNewWord;

@property (weak, nonatomic) IBOutlet UILabel *pr_uk;
@property (weak, nonatomic) IBOutlet UILabel *pr_us;
@end

@implementation WordDetailController


@synthesize data;
- (IBAction)backToRoot:(id)sender {
    [[self navigationController]popToRootViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addShadow:self.wordView];
    [self addShadow:self.addNewWord];
    [self addShadow:self.wordList];
    
    self.wordList.delegate = self;
    self.wordList.dataSource = self;
    
    self.pr_uk_mp3.url = data->uk_mp3;
    self.pr_us_mp3.url = data->us_mp3;
    self.wordName.text = data->wordName;
    self.pr_uk.text = [[@"uk[" stringByAppendingString: data->pr_uk] stringByAppendingString:@"]"];
    self.pr_us.text = [[@"us[" stringByAppendingString:data->pr_us]stringByAppendingString:@"]"];
    self.definitions.text = data->definitons;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIdentifier = @"word";
    CellController * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        cell = [[CellController alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
  
    NSDictionary * word =(NSDictionary *)data->similitudeWordList[indexPath.row];
    
    
    cell.wordId.text = word[@"id"];
    cell.word.text =word[@"word_name"];
    cell.definitions.text = word[@"definitions"];
    cell.likesNumber.text = word[@"like_numbers"];
    
    return cell;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data->similitudeWordList.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toSelf"]) {
        WordDetailController * wordDetailView = segue.destinationViewController;
        WordData * wordData = [[WordData alloc]initWithWord:[[sender word] text]];
        if(wordData->status == -2)return;
        wordDetailView.data = wordData;
        return;
    }
    if([segue.identifier isEqualToString:@"addWord"]){
        AddWordController * addWordView = segue.destinationViewController;
        addWordView.word = self.wordName.text;
        return;
    }
    
}

-(void)addShadow:(UIView *)component {
    CALayer * layer = component.layer;
    layer.cornerRadius = 1;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 1.5);
    layer.shadowOpacity = 0.2;
    layer.shadowRadius = 1;
}
- (IBAction)addWord:(id)sender {
    [self performSegueWithIdentifier:@"addWord" sender:self];
}

- (void)viewDidAppear:(BOOL)animated {
    
}
- (IBAction)play:(Button *)sender {
    NSURL * url = sender.url;

    NSData * audioData = [NSData dataWithContentsOfURL:url];
    
    self.player = [[AVAudioPlayer alloc] initWithData:audioData error:nil];
    
    [self.player prepareToPlay];
    [self.player play];
}



@end
