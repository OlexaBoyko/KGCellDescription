//
//  KGCellDescription.h
//  
//
//  Created by Olexa Boyko on 5/10/17.
//  Copyright © 2017 Olexa Boyko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CDSelectionTypeCommon,
    CDSelectionTypeNone,
    CDSelectionTypeExtendable,
} CDSelectionType;

@interface KGCellDescription : NSObject

@property (nonatomic) CDSelectionType selectionType;
@property (class, nonatomic, readonly) NSString *nibName;
@property (class, nonatomic, readonly) NSString *reuseIdentifier;
@property (nonatomic) CGFloat height;

+ (void)registerCellFor:(UITableView*)tableView;
- (void)setUpCell:(UITableViewCell*)cell;
- (UITableViewCell* )instantiateCellForTableView:(UITableView *)tableView;

@end
