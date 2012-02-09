// Copyright 2012 BeWiTEC - HTW Berlin
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

#import "HTWListViewController.h"

@implementation HTWViewController

@synthesize displayLabel;
@synthesize model;

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  // initialize the calculator model and 
  // the boolean value (user is currently not typing)
  model = [[HTWCalculatorModel alloc] init];
  userIsTypingNumber = NO;
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

- (IBAction)digitPressed:(UIButton *)sender {
  NSString *digit = [[sender titleLabel] text];
  
  // print the text of the pressed button to console
  //NSLog(@"%@", digit);
  
  if (userIsTypingNumber) {
    [displayLabel setText:[[displayLabel text] stringByAppendingString:digit]];
  } else {
    [displayLabel setText:digit];
    userIsTypingNumber = YES;
  }
}

- (IBAction)operandPressed:(UIButton *)sender {
  if (userIsTypingNumber) {
    NSString *operandString = [displayLabel text];
    // replace "," with ".", otherwise the string cannot be converted to double
    operandString = [operandString stringByReplacingOccurrencesOfString:@"," withString:@"."];
    // save the displayed value to model
    [[self model] setOperand:[operandString doubleValue]];
    // finish current number input
    userIsTypingNumber = NO;
  }
  NSString *operation = [[sender titleLabel] text];
  // perform calculation
  double result = [[self model] performOperation:operation];
  // display the result of calculation in our display
  [displayLabel setText:[NSString stringWithFormat:@"%g", result]];
}

- (IBAction)commaPressed:(UIButton *)sender {
  if (userIsTypingNumber) {
    // is a there is no comma within the current string than add one
    if ([[displayLabel text] rangeOfString:[[sender titleLabel] text]].location == NSNotFound) {
      [self digitPressed:sender];
    }
  } else {
    [self digitPressed:sender];
  }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  [(HTWListViewController *)[segue destinationViewController] setModel:[self model]];
}

@end
