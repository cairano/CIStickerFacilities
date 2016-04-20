//
//  ViewController.m
//  SuperLike
//
//  Created by Carlos Irano on 3/25/16.
//  Copyright © 2016 Carlos Irano. All rights reserved.
//

#import "ViewController.h"
#import "DAKeyboardControl.h"
#import "CIStickerFacilities.h"

@interface ViewController ()

- (IBAction)attachStickerWithMessage:(UIButton *)sender;
- (IBAction)sendSticker:(UIButton *)sender;
- (IBAction)didTapScreen:(UITapGestureRecognizer *)sender;

@property (strong, nonatomic) IBOutlet UIView *keyboardView;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UITextView *textView;
@property (nonatomic) UIToolbar *toolBar;
@property (nonatomic) NSMutableArray *chatLines; // -> just one example to see the chat working!

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    // Do any additional setup after loading the view, typically from a nib.
    
    // -> navigation bar
    /* navigation bar
    self.title = @"Super Hero Like";
    self.view.backgroundColor = [UIColor lightGrayColor]; */
    
    
    [self createTableView];
    
    [self createChatBar];
    
    [self createKeyboard];
    
    _chatLines = [[NSMutableArray alloc] init];
    
    
    self.view.keyboardTriggerOffset = _toolBar.bounds.size.height;
    
    __weak ViewController *self_ = self;
    
    [self.view addKeyboardPanningWithActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing) {
        
        CGRect toolBarFrame = self_.toolBar.frame;
        toolBarFrame.origin.y = keyboardFrameInView.origin.y - toolBarFrame.size.height;
        self_.toolBar.frame = toolBarFrame;
        
        CGRect tableViewFrame = self_.tableView.frame;
        tableViewFrame.size.height = toolBarFrame.origin.y - 1;
        self_.tableView.frame = tableViewFrame;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ChatMessage

- (void)sendMessage {
    
    [_chatLines addObject:@{@"message": _textView.attributedText}];
    
    _textView.text = @""; // -> clean message field
    
    [_tableView reloadData];
}

- (IBAction)attachStickerWithMessage:(UIButton *)sender {
    
    // get the image name from the description in button attributes 
    NSString *imgName = sender.titleLabel.text;
    
    [CIStickerFacilities attachStickerFromImage:imgName inTextView:_textView];
}

- (IBAction)sendSticker:(UIButton *)sender {
    
    // generate and send sticker to chat line
    [_chatLines addObject:@{@"message": [CIStickerFacilities createStickerFromImage:@"MicheyMouse"]}];
    
    [_tableView reloadData];
}


#pragma mark Keyboard

- (void)animateKeyboardToHide {
    
    [CIStickerFacilities animateToHideKeyboard:_keyboardView usingChatToolBar:_toolBar andChatView:self.view];
}

- (void)animateKeyboardToShowHide {
    
    [CIStickerFacilities animateToShowKeyboard:_keyboardView usingChatToolBar:_toolBar andChatView:self.view];
}


#pragma mark ViewActions

- (IBAction)didTapScreen:(UITapGestureRecognizer *)sender {
    
    // keyboard is open
    if (!(_keyboardView.frame.origin.y == self.view.frame.size.height)) {
        
        [self animateKeyboardToHide];
    }
    
    [_textView resignFirstResponder];
}


#pragma mark CreateView

- (void)createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height - 40.0f)];
    
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

- (void)createChatBar {
    
    // toolBar
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, self.view.bounds.size.height - 40.0f, self.view.bounds.size.width, 40.0f)];
    _toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_toolBar];
    
    
    // textView
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(50.0f, 6.0f, _toolBar.bounds.size.width - 20.0f - 68.0f - 30.0f, 30.0f)];
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_toolBar addSubview:_textView];
    
    // make a UITextView like a UITextField
    [self.textView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [self.textView.layer setBorderColor: [[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0] CGColor]];
    [self.textView.layer setBorderWidth: 0.6];
    [self.textView.layer setCornerRadius:6.0f];
    [self.textView.layer setMasksToBounds:YES];
    
    
    // sticker button
    UIButton *stickerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    stickerButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    [stickerButton setTitle:@";-)" forState:UIControlStateNormal];
    stickerButton.frame = CGRectMake(10.0f, 6.0f, 40.0f, 29.0f);
    [stickerButton addTarget:self
                      action:@selector(animateKeyboardToShowHide)
            forControlEvents:UIControlEventTouchUpInside];
    [_toolBar addSubview:stickerButton];
    
    
    // send button
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [sendButton setTitle:@"Send" forState:UIControlStateNormal];
    sendButton.frame = CGRectMake(_toolBar.bounds.size.width - 68.0f, 6.0f, 58.0f, 29.0f);
    
    [sendButton addTarget:self
                   action:@selector(sendMessage)
            forControlEvents:UIControlEventTouchUpInside];
    
    [_toolBar addSubview:sendButton];
}

- (void)createKeyboard {
    
    float keyboardHeight = 200.0f; // -> this is the size of the sticker keyboard (maximum size recommended is 259.0f)
    
    _keyboardView.frame = CGRectMake(0.0f, self.view.frame.size.height, self.view.frame.size.width, keyboardHeight);
    
    [self.view addSubview:_keyboardView];
    
    [self.view layoutIfNeeded];
}


#pragma mark UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSDictionary *cellMessage;
    static NSString *CellIdentifier = @"chatline";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cellMessage = _chatLines[indexPath.row];
    
    cell.textLabel.attributedText = cellMessage[@"message"];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section {
    return _chatLines.count;
}

@end
