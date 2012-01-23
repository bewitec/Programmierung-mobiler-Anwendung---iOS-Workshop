// Copyright 2011 BeWiTEC - HTW Berlin
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "HTWViewController.h"

@implementation HTWViewController

@synthesize displayLabel;
@synthesize calculations;

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  lastOperation = @"";
  lastValue = 0;
  calculations = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload {
  [self setDisplayLabel:nil];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
    return YES;
  }
}

#pragma mark - Actions
- (IBAction)tappedNumberButton:(UIButton *)sender {
  // print the text of the pressed button to console
  //NSLog(@"%@", [[sender titleLabel] text]);
  
  // if the displayed number is zero than add our tapped number
  if ([[displayLabel text] isEqualToString:@"0"]) {
    [displayLabel setText:[[sender titleLabel] text]];
  } else { // if not just append the number
    //[displayLabel setText:[NSString stringWithFormat:@"%@%@", [displayLabel text], [[sender titleLabel] text]]];
    [displayLabel setText:[[displayLabel text] stringByAppendingString:[[sender titleLabel] text]]];
  }
}

- (IBAction)tappedClearButton:(UIButton *)sender {
  lastOperation = @"";
  lastValue = 0.0;
  [displayLabel setText:@"0"];
}

- (IBAction)tappedPlusMinusButton:(UIButton *)sender {
  // if there is an minus sign remove it
  if ([[displayLabel text] hasPrefix:@"-"]) {
    [displayLabel setText:[[displayLabel text] stringByReplacingOccurrencesOfString:@"-" withString:@""]];
  } else { // if not than add a minus sign in front of the text
    [displayLabel setText:[NSString stringWithFormat:@"-%@", [displayLabel text]]];
  }
}

- (IBAction)tappedCalculateButton:(UIButton *)sender {
  float result = 0.0;
  
  if (![lastOperation isEqualToString:@""]) {
    // use the lastOperation to connect the lastValue with our current one
    if ([lastOperation isEqualToString:@"+"]) {
      result = lastValue + [[displayLabel text] floatValue];
    } else if ([lastOperation isEqualToString:@"-"]) {
      result = lastValue - [[displayLabel text] floatValue];
    } else if ([lastOperation isEqualToString:@"/"]) {
      result = (float)lastValue / (float)[[displayLabel text] floatValue];
    } else if ([lastOperation isEqualToString:@"x"]) {
      result = lastValue * [[displayLabel text] floatValue];
    }
    // store the values
    [calculations addObject:[NSString stringWithFormat:@"%f%@%@=%f", lastValue, lastOperation, [displayLabel text], result]];
    NSLog(@"%@", calculations);
    [displayLabel setText:[NSString stringWithFormat:@"%f", result]];
    lastValue = result;
  }
}

- (IBAction)tappedOperationButton:(UIButton *)sender {
  lastOperation = [[sender titleLabel] text]; // save the tapped operation for later usage
  lastValue = [[displayLabel text] floatValue]; // save the displayed value
  [displayLabel setText:@"0"]; // reset the display
}

- (IBAction)tappedCommaButton:(UIButton *)sender {
  // is a there is no comma within the current string than add one
  if ([[displayLabel text] rangeOfString:@"."].location == NSNotFound) {
    [displayLabel setText:[[displayLabel text] stringByAppendingString:@"."]];
  }
}

@end
