//
//  ActorViewController.m
//  MovieList
//
//  Created by T on 2014. 1. 14..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "ActorViewController.h"
#import "MovieCenter.h"

@interface ActorViewController () <UITableViewDataSource>

@end

@implementation ActorViewController{
    MovieCenter *_movieCenter;
}

- (IBAction)addActor:(id)sender {
    // TODO alert view
    [_movieCenter addActorWithName:@"스칼렛" inMovie:self.movieIndex];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_movieCenter getNumberOfActorsInMovie:self.movieIndex];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ACTOR_CELL" forIndexPath:indexPath];
    cell.textLabel.text = [_movieCenter getNameOfActorAtIndex:indexPath.row inMovie:self.movieIndex];
    return cell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _movieCenter = [MovieCenter sharedMovieCenter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
