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

#import "HTWCalculatorModel.h"

@interface HTWCalculatorModel (PrivateMethods)
- (void)performWaitingOperation;
@end

@implementation HTWCalculatorModel

@synthesize operand;
@synthesize calculations;

- (id)init {
  self = [super init];
  if (self) {
    // initialize an empty array of calculations when model is created
    calculations = [[NSMutableArray alloc] init];
    // last calculation is an empty string
    tmpCalculation = @"";
  }
  return self;
}

- (double)performOperation:(NSString *)operation {
  // concatenate string for storage of calculations
  tmpCalculation = [tmpCalculation stringByAppendingFormat:@"%g%@", operand, operation];
  
  if ([operation isEqualToString:@"sqrt"]) {
    // perform square root operation
    [self setOperand:sqrt(operand)];
  } else if ([@"+/-" isEqualToString:operation]) {
    // change algebraic sign
    operand = operand * -1;
  } else {
    [self performWaitingOperation];
    waitingOperation = operation;
    waitingOperand = operand;
  }
  // if calculation is finished store the calculation string for display
  if ([@"=" isEqualToString:operation]) {
    tmpCalculation = [tmpCalculation stringByAppendingFormat:@"%g", operand];
    [calculations addObject:tmpCalculation];
    tmpCalculation = @"";
  }
  return operand;
}

#pragma mark - Private Methods

- (void)performWaitingOperation {
  if ([@"+" isEqualToString:waitingOperation]) {
    operand = waitingOperand + operand;
  } else if ([@"-" isEqualToString:waitingOperation]) {
    operand = waitingOperand - operand;
  } else if ([@"*" isEqualToString:waitingOperation]) {
    operand = waitingOperand * operand;
  } else if ([@"/" isEqualToString:waitingOperation]) {
    if (operand > 0) {
      operand = waitingOperand / operand;
    }
  }
}

@end
