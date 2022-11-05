# Crypto Radar
Project built on Coin Gecko API with SwiftUI

> An app using CoinGecko API to display the top 10 crypto by market cap. Also you can navigate through detail section that show general information, market chart and project link.

## Table of Contents

* [Getting Started](#getting-started)

* [General Info](#general-info)

* [Screenshots](#screenshots)

* [Requirements](#requirements)


## Getting Started
- [Download](https://developer.apple.com/downloads/index.action)  and install Xcode.  _Crypto Radar_  requires Xcode 13.0.0 or newer.
- From a command line, run the following snippet in the folder of your preference.
```bash
 git clone "https://github.com/Farinos/crypto-radar.git"
```
- Now, to enter the working directory.
```bash
  cd crypto-radar
```
- In terminal 
```bash
 open CryptoRadar.xcodeproj.
```
- Enjoy :D

## General Info
App consist of two screens.
The first shows a list of the top 10 crypto by market cap, and the last shows selected crypto details.

The app uses the model view intent (MVI) architecture. 
Every screen is a group of 3 folders.

- MainView
   - Model
   - View
   - Intent  

The networking layer was built with generics using Async/Await API.
To made a netowrk request simply call perform(RequestProtocol) and wait for response. 

```swift
 RequestManager().perform(CoinGeckoRequest.getCoinsList(currency: "eur", perPage: "10", page: "1"))
```
Where CoinGeckoRequest is an enum that wrap the Coin Gecko API conform to RequestProtocol

## Screenshots
<img width="300" alt="coinList" src="https://user-images.githubusercontent.com/51165492/200034949-fcbdc243-e678-4235-b8af-c53829ec3ec7.png"> <img width="300" alt="coinDetail" src="https://user-images.githubusercontent.com/51165492/200034971-2cc3ac99-063e-432f-8f06-8997e7c6a709.png">

## Requirements
* iOS 15.0+
* Xcode 13+
* Swift 5.5+

