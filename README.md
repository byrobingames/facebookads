## Stencyl Facebook Advertising Extension (Openfl)

For Stencyl 3.4 9280 and above

Stencyl extension for “Facebook Audience Network” on iOS and Android. This extension allows you to easily integrate Facebook Audience Network on your Stencyl game / application. (http://www.stencyl.com)

### Important!!

This Extension Required the Toolset Extension Manager [https://byrobingames.github.io](https://byrobingames.github.io)

![facebookadstoolset](https://byrobingames.github.io/img/facebookads/facebookadstoolset.png)

## Main Features

  * Banners & Interstitial Support.
  * Setup your banners to be on top or on the bottom of the screen.
  
## How to Install

To install this Engine Extension, go to the toolset (byRobin Extension Mananger) in the Extension menu of your game inside Stencyl.<br/>
Select the Engine Extension from the left menu and click on "Download"

If you not have byRobin Extension Mananger installed, install this first.<br/>
Go to: [https://byrobingames.github.io](https://byrobingames.github.io)

## Documentation and Block Examples

<strong>Step 1:</strong> Apply for Audience Network

Submit your app to join the network with a few quick steps<br/>
https://developers.facebook.com/docs/audience-network<br/>
![image006](https://byrobingames.github.io/img/facebookads/image006.png)

<strong>Step 2:</strong> Enter your Company Information

Once your app is accepted into Audience Network, you’ll need to provide us with basic information about your company.

In your app’s [settings page](https://developers.facebook.com/apps), click on the Audience Network section located at the bottom left:<br/>
![image008](https://byrobingames.github.io/img/facebookads/image008.png)

If you have an existing company that you registered with Facebook, you can select it here and accept the terms to continue. Otherwise, you can choose Quick Start to enter basic details about your company.

Your app needs to be approved for Audience Network to provide these details. To apply, visit [this page](https://developers.facebook.com/docs/audience-network) If you choose Quick Start, please fill out your account and tax info under the Payout tab. Though integration is possible without these details, ad delivery will pause when your account balance reaches $100.

<strong>Step 3:</strong> Create Placement IDs

Facebook’s Audience Network offers a few types of ad units: banner, interstitial and native ads through our API. Each placement of an ad unit in your app is identified using a unique placement ID. The first step in adding an ad unit is to create this identifier.

Your app needs to be approved for Audience Network before you can create placement IDs. To apply, visit [this page](https://developers.facebook.com/docs/audience-network) .

In your app’s [settings page](https://developers.facebook.com/apps), click on the Audience Network section. Then, choose the Placements tab and click on the ‘Create Ad placement’ button to create your placement:<br/>
![image010](https://byrobingames.github.io/img/facebookads/image010.png)

Enter a name and an optional description. If the placement will be used for a banner, you can specify the ad refresh interval (please note that if you use a mediation service this option should be set to ‘None’):<br/>
![image012](https://byrobingames.github.io/img/facebookads/image012.png)

Save the Ad Placement and the placement ID will show in the list.

Reporting and ad unit refresh interval are tied to a placement ID. Please make sure to use a different placement ID for each ad unit you show in your app.

<strong>Step 4:</strong> Incorporate Ad Units in Your App

Once you have the placement ID, follow our iOS and Android specific guides to add the ad units in your app:

![facebookadstoolset](https://byrobingames.github.io/img/facebookads/facebookadstoolset.png)

Create different placement ID for Banner, Medium Rect and Interstial Ad.

1-     Initialize in first scene. (example in load scene)<br/>
![image014](https://byrobingames.github.io/img/facebookads/image014.png)

2-     Show/Hide/Move Ads in your game, load Interstitial ad before showing. Look at the example game, that you can download from [here](http://community.stencyl.com/index.php/topic,41144.0.html)<br/>
![image016](https://byrobingames.github.io/img/facebookads/image016.png)

![image018](https://byrobingames.github.io/img/facebookads/image018.png)

![image020](https://byrobingames.github.io/img/facebookads/image020.png)

Before submitting your iOS app to Apple, please see our FAQ regarding answers to IDFA questions in their submission process.

<strong>Step 5:</strong> Track the Ad Placement Performance

After your app is live with Audience Network, use the Performance dashboards to track revenue estimates and additional metrics like impressions and clicks.

To access the dashboards, in your app’s [settings page](https://developers.facebook.com/apps), click on Audience Network and then choose the Performance tab:<br/>
![image022](https://byrobingames.github.io/img/facebookads/image022.png)

In addition, you can access your performance data via an API. Please see [this guide](https://developers.facebook.com/docs/audience-network/reporting-api) for more info

## Version History

- 2015-05-11 (1.0) : First release
- 2015-06-13 (1.1) : update info.txt file
- 2015-08-01 (1.2) : now download it from github
- 2016-03-28 (1.3) Updated SDK to 4.10.1
- 2016-09-30 (1.4) Updated iOS and Android SDK to 4.16.0
- 2016-11-18 (1.5)  Updated for Heyzap Extension 2.7
- 2017-03-19 (1.6)  Updated to use with Heyzap Extension 2.9, Update SDK to iOS: 4.20.2 Android: 4.20.0, Added Android Gradle support.
- 2017-05-16(1.6.1) Update SDK to iOS: 4.22 Android: 4.22, Tested for Stencyl 3.5, Required byRobin Toolset Extension Manager

## Submitting a Pull Request

This software is opensource.<br/>
If you want to contribute you can make a pull request

Repository: [https://github.com/byrobingames/facebookads](https://github.com/byrobingames/facebookads)

Need help with a pull request?<br/>
[https://help.github.com/articles/creating-a-pull-request/](https://help.github.com/articles/creating-a-pull-request/)

## Donate

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HKLGFCAGKBMFL)<br />

## Privacy Policy

https://www.facebook.com

## License

Author: Robin Schaafsma

The MIT License (MIT)

Copyright (c) 2014 byRobinGames [http://www.byrobin.nl](http://www.byrobin.nl)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
