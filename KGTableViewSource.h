//
//  KGTableViewSource.h
//  Boating
//
//  Created by Olexa Boyko on 5/11/17.
//  Copyright © 2017 Olexa Boyko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KGCellDescription.h"

@interface KGTableViewSource : NSObject<UITableViewDataSource>

@property (weak, nonatomic) UITableView* tableView;

-(void)clearTable;
-(void)addSectionWithCellDescriptionsArray:(NSArray<KGCellDescription*>*)cellDescriptionsArray;
-(NSIndexPath*)indexPathForCellDescription:(KGCellDescription*)cell;
-(KGCellDescription*)cellDescriptionAtIndexPath:(NSIndexPath*)indexPath;
-(CGFloat)heightForRowAtIndexpath:(NSIndexPath*)indexPath;

@end
