<H1 align ="center">Real Selfie - A WYSIWYG Camera</H1>

<p align="center">
  <img src="Round-Icon.png" alt="Icon"/>
</p>


##App Store Description
Have you ever noticed that your image on the mirror actually isn't how the world sees you? What if I told you that your front cam acts like a mirror? It's frustrating to have your selfies mirrored when you take them, isn't it.

Now Real Selfie delivers to you the first live preview of how the world actually sees you! You can then snap and share pictures with your friends.

The first What You See Is What You Get camera, that prevents you from being surprised by the picture you're about to take.

Try this mindblowing cam and see what's like to see yourself through someone else's eyes!

##Cutting To The Chase
Real Selfie is a personal project that I used to develop some technical skills (listed below), besides actually solving a problem that I had.

First of all, this app isn't intended for everyone. First, you have to (obviously) be someone that does take selfies. Said that, I present you:

###The Problem
Your iPhone front cam automatically mirrors the image for you, so it looks natural while you're looking at yourself through your phone's screen. So, if you raise your right hand, you'll see your hand raised in the right side of the screen, in other words, your virtual self raised its left hand.

But, as soon as you take your picture, your phone will save it as any other picture taken with the rear cam (without mirroring). That leads us to a problem which's that the preview that you had previously, doesn't match with the actual result obtained.

Real Selfie is here to avoid that.

###The Solution

Bringing to you the first live preview of what your result image will be like. It's a WYSIWYG cam that will show exactly what your picture's going to be.

Along with this feature, you're also able to swipe the screen to flip the camera mirroring, so you can take a selfie in either side.

###Side Effects

There are three side effects when using Real Selfie:

- Relatively decreased photo quality, compared to native front cam, but maybe it's not even noticeable. This is because the picture is actually a photo from the video preview layer. This should be fixed in a later release.
- Depending on which mirroring configuration you use to take your selfies, it may not reflect reality (how you really look like). You may take selfies as _How The World Sees You_ or _How You See Yourself In The Mirror_. This makes more sense for people that have noticeable uneven attributes like scars, 
- While using _How The World Sees You_ config, you may notice it's strange how to camera will reflect your movements. This is completely normal, since it will not act like a real mirror.

##Learned Skills
Like stated above, I built this project mainly to learn some technical concepts myself. So far I've learned a quite few of them, and I intend to learn a few more as I walk along the road map.

So far:

- AVFoundation
- UIAccelerometer (deprecated)
- Extended Auto Layout knowledge (multipliers, relations and priority)
- Class extensions
- MVVM architecture
- Extended block knowledge
- File handling directly in Application Documents Directory

##Road Map

- Add app Introduction (MYBlurIntroductionView or similar)
- Change the Last Selfie ViewController to something faster instead of a modal (like UIScrollView) 
- Smart UX when requesting for Permissions
- Front flash
- Replace UIAccelerometer with CMMotionManager
- Add shutter function to the volume buttons
- Add gesture animations (Possibly make a framework out of Gesture Tutorials)
- See if the front cam can be used without the preview layer that's being used, looking to use the system's native front cam system, improving the quality of the image drastically along with other features (better auto-focus, wider lens angle, better light detection, etc). To see the differences, compare the image taken from Real Selfie and the native iOS front cam.

##Known Bugs

- [FIXED] ~~If the orientation changes while in Last Selfie VC and you go back to CameraVC, the preview layer glitches.~~

##Changelog

- v1.0
    - First release
    - Tutorial screen
    - Use accelerometer to determine device/interface orientation
    - Ability to swipe to change the camera mirroring

##Credits

These articles helped me learn fundamental MVVM knowledge and how to shrink my view controllers.

[Put Your UIViewController On A Diet](http://blog.ios-developers.io/put-your-uiviewcontroller-on-a-diet/)

[Don't Let Your UIViewController Think For Itself](http://blog.ios-developers.io/dont-let-your-uiviewcontroller-think-for-itself/)

Thanks [@IanKeen](https://github.com/IanKeen) for the articles above!
And thanks [@andysolomon](https://twitter.com/andysolomon) for some design advices and tips!

I must also state that in the App Store screenshots I used someone's photo posted in [GregPC's 1000 Photos Project](https://www.flickr.com/photos/gregpc/albums), and I took the photo from [here](https://www.flickr.com/photos/gregpc/20380375058/in/album-72157629602035180/). Thanks a lot for offering that pic under CC 2.0 License! 

##Contact

Twitter: [@Rogerluan\_](https://twitter.com/rogerluan_)

##License

MIT License.