//
//  TSViewController.m
//  TSOpenApp
//
//  Created by tch85683282 on 07/22/2019.
//  Copyright (c) 2019 tch85683282. All rights reserved.
//

#import "TSViewController.h"
#import <TSOpenAppSchemes.h>

@interface TSViewController ()

@end

@implementation TSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[TSOpenAppSchemes shareManager] OpenWithType:TSOpenAppSchemesTypeWeiDianBuyer itemid:@"2852002679" detailIndex:0 webUrl:@"https://detail.tmall.com/item.htm?id=586900761105"];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
