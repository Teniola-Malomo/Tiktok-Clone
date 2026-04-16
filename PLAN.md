# Short Video Feed - Implementation Plan

## Existing Codebase
UIKit + MVVM + RxSwift. Already has: vertical paging feed (UITableView), AVQueuePlayer with looping, two-tier video cache (memory + disk), home feed UI with like/comment/share overlays, profile grid layout, tab bar, Lottie loading animation.

Currently wired to **Firebase** — needs to switch to **Pexels API**.

---

## Phase 1: Swap Data Source (Firebase → Pexels API)
- Update `Post` model to match Pexels video response (id, video files, user, dimensions)
- Replace `PostsRequest` Firebase calls with Pexels API requests (`https://api.pexels.com/videos/search?query=people&per_page=80&page=1..3`)
- Store API key securely (e.g. in a config file excluded from git)
- Update `HomeViewModel` to load from new network layer
- Remove Firebase dependencies (Podfile, GoogleService-Info.plist, imports)

## Phase 2: Like Persistence
- Add `UserDefaults`-backed store for liked video IDs + counts
- Wire like button to persist state across sessions

## Phase 3: Profile Screen Completion
- Trim tab bar to 2 tabs: Feed / Profile
- Remove Discover, Inbox, Media stubs
- Profile header: placeholder avatar, username, video count, total likes
- Grid shows random subset of videos from the dataset
- Tap grid item → navigate to feed and play that video

## Phase 4: Cleanup
- Remove unused modules: `Media/`, `Discover/`, `Inbox/`
- Remove unused pods: `MarqueeLabel`, `Firebase/*`, `lottie-ios` (if not needed)
- Remove Camera-related code (`CameraManager`, permissions)
- Strip dead code and empty stubs

## Phase 5: Tests
- Unit test: Pexels JSON parsing (decode API response)
- Unit test: LikesStore (toggle, persist, read)
- Unit test: HomeViewModel business logic

## Phase 6: Deliverables
- Write README (setup, architecture, tradeoffs, improvements)
- TestFlight build
