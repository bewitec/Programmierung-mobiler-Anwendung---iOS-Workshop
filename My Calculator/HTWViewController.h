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

#import <UIKit/UIKit.h>

@interface HTWViewController : UIViewController {
  NSString *lastOperation;
  float lastValue;
  
  // Array of finished calculations
  NSMutableArray *calculations;
}

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (strong, nonatomic) NSMutableArray *calculations;

- (IBAction)tappedNumberButton:(UIButton *)sender;
- (IBAction)tappedClearButton:(UIButton *)sender;
- (IBAction)tappedPlusMinusButton:(UIButton *)sender;
- (IBAction)tappedCalculateButton:(UIButton *)sender;
- (IBAction)tappedOperationButton:(UIButton *)sender;
- (IBAction)tappedCommaButton:(UIButton *)sender;

@end
