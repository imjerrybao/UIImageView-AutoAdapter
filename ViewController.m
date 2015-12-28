//
//  ViewController.m
//  UIImageView+AutoAdapter
//
//  Created by Jiar on 15/12/28.
//  Copyright © 2015年 Jiar. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+AutoAdapter.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *first;
@property (weak, nonatomic) IBOutlet UIImageView *second;
@property (weak, nonatomic) IBOutlet UIImageView *third;
@property (weak, nonatomic) IBOutlet UIImageView *fourth;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.fourth setCloseAdapter:YES];
}

@end
