# Short Video Feed

This project was built on top of an existing open-source TikTok clone. The original app used Firebase, which I swapped out for the Pexels API. I forked the repo and used it as my starting point. - https://github.com/dks333/Tiktok-Clone

## Setup Steps

You need to run `pod install` in the `KD Tiktok-Clone/` directory to install dependenices.

You'll need to register a Pexels API key at [pexels.com/api](https://www.pexels.com/api/) and add it to a `Secrets.plist` file in `KD Tiktok-Clone/KD Tiktok-Clone/`:

From the Xcode interface: `Cmd+B` to build, `Cmd+R` to run.

## Architectural Overview

I followed MVVM (Model-View-ViewModel). The original app already had most of the features done, so I made sure to follow the existing pattern.

Key folders:

- **Network/** -handles external requests.
- **Entity/** -data modelling.
- **Modules/** - the UI components. Most of the content is rendered in `HomeTableViewCell`.

## Tradeoffs and Known Limitations

Currently, content is streamed from Pexels' videos and pulled in chunks but never saved to cache. This means that if you scroll to the next video and go back up, you'll have to reload the video and start from the beginning and make the same request. Ideally, it's better to cache the existing video after it's been played, and then after some duration of time it gets cleared, probably when the app gets closed.

The Pexels API returns multiple different video formats: SD, Ultra HD, and HD. I went with HD as a middle ground between the two. Ideally, there should be some kind of mechanism to adaptively check the bandwidth or what the phone can support and then return the best option.

## What I'd Improve With More Time

If I had extra time, I would definitely focus more on the UI. I focused on getting the functional requirements done and nailed first. A definite improvement would be to mirror the way TikTok loads its content for mobile, and making sure there's buffering of the next few videos as you scroll. 
