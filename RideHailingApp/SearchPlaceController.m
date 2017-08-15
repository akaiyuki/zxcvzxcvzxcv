//
//  SearchPlaceController.m
//  RideHailingApp
//
//  Created by AV Dev on 07/08/2017.
//  Copyright © 2017 AV Dev. All rights reserved.
//

#import "SearchPlaceController.h"
#import <GooglePlaces/GooglePlaces.h>


@interface SearchPlaceController ()<GMSAutocompleteViewControllerDelegate>

@end

@implementation SearchPlaceController



-(void)loadView{
     self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    CGFloat xCenter = [UIScreen mainScreen].bounds.size.width/2 - 100/2;
    
    UIButton *btnRegister = [[UIButton alloc] initWithFrame:CGRectMake(xCenter,200, 100, 40)];
    [btnRegister setTitle:@"Sign Up" forState:UIControlStateNormal];
    [btnRegister setBackgroundColor: [UIColor clearColor]];
    [btnRegister setTitleColor:UIColor.greenColor forState:normal];
    [btnRegister addTarget:self action:@selector(searchFunction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRegister];
}


// Present the autocomplete view controller when the textfield is pressed.
- (void)searchFunction:(id)sender {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
}

// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
