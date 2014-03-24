//
//  WebViewController.m
//  iOS-UIWebView-Browser
//
//  Created by Pablo Eduardo Ojeda Vasco on 24/03/14.
//  Copyright (c) 2014 SpeakinBytes. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

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
    // Do any additional setup after loading the view from its nib.
    
    // Asignamos delegado
    self.webView.delegate = self;
    
    //web que queremos cargar
    [self loadRequestFromString:@"http://www.speakinbytes.com"];
}

- (void)loadRequestFromString:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - webView delegate
#pragma mark -
- (void)webView:(UIWebView *)web didFailLoadWithError:(NSError *)error
{
    NSLog(@"Entro en %s", __PRETTY_FUNCTION__);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateButtons];
    
    // Si falla la carga
    [self.spinner stopAnimating];
    self.lbLoading.hidden=YES;
    
	// Si es error -999 no lo tenemos en cuenta
	if (error.code == NSURLErrorCancelled) return;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
    
}

- (BOOL)webView:(UIWebView *)web shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"Entro en %s", __PRETTY_FUNCTION__);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)web
{
    NSLog(@"Entro en %s", __PRETTY_FUNCTION__);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateButtons];
    
    //Activamos el activity y mostramos el label de cargando hasta que se cargue definitivamente la web
    [self.lbLoading setHidden:NO];
    [self.spinner setHidesWhenStopped:YES];
    [self.spinner setHidden:NO];
    [self.spinner startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)web
{
    NSLog(@"Entro en %s", __PRETTY_FUNCTION__);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateButtons];
    
    //ocultamos el activity y el label cargando cuando todo ha ido bien
    [self.spinner stopAnimating];
    self.lbLoading.hidden=YES;
}

- (void)updateButtons
{
    self.btnForward.enabled = self.webView.canGoForward;
    self.btnBack.enabled = self.webView.canGoBack;
    self.btnStop.enabled = self.webView.loading;
}


@end
