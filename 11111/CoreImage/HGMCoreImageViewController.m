//
//  HGMCoreImageViewController.m
//  11111
//
//  Created by Nick on 2018/7/31.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMCoreImageViewController.h"

@interface HGMCoreImageViewController ()

@end

@implementation HGMCoreImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self rightBarButton];
    [self testCoreImage];
}

- (void)rightBarButton {
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)testCoreImage {
    // Create URL to image file // timg.jpeg // GodfreyKneller-IsaacNewton-1689.jpg
    NSURL* imageURL = [[NSBundle mainBundle] URLForResource:@"GodfreyKneller-IsaacNewton-1689.jpg" withExtension:nil];
    // Load image into program
    CIImage* ciImage = [CIImage imageWithContentsOfURL:imageURL];
    CIContext * context = [CIContext contextWithOptions:nil];

    // 对图片做模糊处理
    CIFilter * blurFilter =
    [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:ciImage forKey:kCIInputImageKey];
    
    CGImageRef ref = [context createCGImage:blurFilter.outputImage fromRect:[blurFilter.outputImage extent]];
    UIImage *resultImg = [UIImage imageWithCGImage:ref];
    
    // 对图片做一系列处理,上一步的输出作为下一步的输入
    CIFilter * randomFilter = [CIFilter filterWithName:@"CIRandomGenerator"];
    CIFilter * pixelFilter = [CIFilter filterWithName:@"CIPixellate"];
    [pixelFilter setValue:randomFilter.outputImage forKey:kCIInputImageKey];
    CIFilter * distortionFilter = [CIFilter filterWithName:@"CIHoleDistortion"];
    [distortionFilter setValue:pixelFilter.outputImage forKey:kCIInputImageKey];
    [distortionFilter setValue:@40 forKey:kCIInputRadiusKey];
    [distortionFilter setValue:[CIVector vectorWithX:100 Y:400] forKey:kCIInputCenterKey];
    CIImage * outImage = distortionFilter.outputImage;
    CGImageRef refff = [context createCGImage:outImage fromRect: CGRectMake(0, 0, resultImg.size.width, resultImg.size.height)];
    UIImage *filterChianImg = [UIImage imageWithCGImage:refff];
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:filterChianImg];
    imageView.frame = CGRectMake(10, 100, 300, 400);
    
    [self.view addSubview:imageView];
}

#pragma mark - doneAction

- (void)doneAction {
//    [self.navigationController popViewControllerAnimated:YES];
}

@end
