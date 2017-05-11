//
//  KGTableViewSource.m
//  
//
//  Created by Olexa Boyko on 5/11/17.
//  Copyright © 2017 Olexa Boyko. All rights reserved.
//

#import "KGTableViewSource.h"

@interface KGTableViewSource()

@property (strong, atomic) NSMutableArray<NSArray<KGCellDescription*>*>* cellDescriptionArray;


@end

@implementation KGTableViewSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cellDescriptionArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    _tableView.dataSource = self;
    [self registerCells];
    
}

-(void)clearTable {
    _cellDescriptionArray = [[NSMutableArray alloc] init];
}

-(void)addSectionWithCellDescriptionsArray:(NSArray<KGCellDescription*>*)cellDescriptionsArray {
    [_cellDescriptionArray addObject:cellDescriptionsArray];
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
    if (!_tableView)
    {
        return;
    }
    
    NSMutableSet<NSString *> *set = [[NSMutableSet<NSString *> alloc] init];
    
    for (NSArray<KGCellDescription *> *section in _cellDescriptionArray) {
        for (KGCellDescription* row in section) {
            if(![set containsObject:[[row class] reuseIdentifier]]) {
                [[row class] registerCellFor:_tableView];
                [set addObject:[[row class] reuseIdentifier]];
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [_cellDescriptionArray[section] count];
    if (count) {
        return count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [_cellDescriptionArray[indexPath.section][indexPath.row] instantiateCellForTableView:tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = [_cellDescriptionArray count];
    
    if (count) {
        return count;
    }
    
    return 0;
}

@end
