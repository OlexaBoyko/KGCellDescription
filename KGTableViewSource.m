//
//  KGTableViewSource.m
//  Boating
//
//  Created by Olexa Boyko on 5/11/17.
//  Copyright © 2017 Olexa Boyko. All rights reserved.
//

#import "KGTableViewSource.h"

@interface KGTableViewSource()

@property (strong, atomic) NSArray<NSArray<KGCellDescription*>*>* cellDescriptionArray;


@end

@implementation KGTableViewSource

-(void)clearTable {
    
}

-(void)addSectionWithCellDescriptionsArray:(NSArray<KGCellDescription*>*)cellDescriptionsArray {
    
}

-(NSIndexPath*)indexPathForCellDescription:(KGCellDescription*)cell {
    for (NSUInteger i = 0; i < self.cellDescriptionArray.count; i++) {
        for (NSUInteger j = 0; j < self.cellDescriptionArray[i].count; j++) {
            if (_cellDescriptionArray[i][j] == cell) {
                return [NSIndexPath indexPathForRow:j inSection:i];
            }
        }
    }
    
    return nil;
}


-(KGCellDescription*)cellDescriptionAtIndexPath:(NSIndexPath*)indexPath {
    return self.cellDescriptionArray[indexPath.section][indexPath.row];
}


-(CGFloat)heightForRowAtIndexpath:(NSIndexPath*)indexPath {
    return [self cellDescriptionAtIndexPath:indexPath].height;
}

-(void)registerCells {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [self.cellDescriptionArray[section] count];
    if (count) {
        return count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.cellDescriptionArray[indexPath.section][indexPath.row] instantiateCellForTableView:tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = [self.cellDescriptionArray count];
    
    if (count) {
        return count;
    }
    
    return 0;
}

@end
