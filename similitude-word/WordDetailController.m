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

@property (weak, nonatomic) IBOutlet UIButton *sortBtn_all;
@property UIButton * LAST_BTN;

@end



@implementation WordDetailController


@synthesize data;
@synthesize originalData;
- (IBAction)backToRoot:(id)sender {
    [[self navigationController]popToRootViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //addshadow
    [self addShadow:self.wordView];
    [self addShadow:self.addNewWord];
    [self addShadow:self.wordList];
    
    //set TableView delegate
    self.wordList.delegate = self;
    self.wordList.dataSource = self;
    
    //set wordDetail
    self.pr_uk_mp3.url = originalData->uk_mp3;
    self.pr_us_mp3.url = originalData->us_mp3;
    self.wordName.text = originalData->wordName;
    self.pr_uk.text = [[@"uk[" stringByAppendingString: originalData->pr_uk] stringByAppendingString:@"]"];
    self.pr_us.text = [[@"us[" stringByAppendingString:originalData->pr_us]stringByAppendingString:@"]"];
    self.definitions.text = originalData->definitons;
    
    //
    self.LAST_BTN = self.sortBtn_all;
    self.data = originalData->similitudeWordList;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIdentifier = @"word";
    CellController * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        cell = [[CellController alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary * word =data[indexPath.row];
    
    
    cell.itemId.text = word[@"id"];
    cell.word.text =word[@"word_name"];
    cell.definitions.text = word[@"definitions"];
    cell.likesNumber.text = word[@"like_numbers"];
    
    return cell;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(data==nil)return 0;
    return data.count;
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
        wordDetailView.originalData = wordData;
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

- (IBAction)sort:(UIButton *)sender {
    if(self.LAST_BTN==sender)return;
    [self wordClassify:sender.tag];
    [self.LAST_BTN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.LAST_BTN = sender;
}

-(void)wordClassify:(long)sortType{
    if(sortType==0)data = originalData->similitudeWordList;
    NSMutableArray * classifiedArray = [[NSMutableArray alloc]init];
    for (NSDictionary * word in originalData->similitudeWordList) {
        if([word[@"tags_id"] containsString:[NSString stringWithFormat:@"%ld",sortType]]){
            [classifiedArray addObject:word];
        }
    }
    data = classifiedArray;
    [self.wordList reloadData];
}



@end
