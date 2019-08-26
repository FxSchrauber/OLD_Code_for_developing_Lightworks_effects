# Auto-synced parameter `_OutputHeight`

**Number of pixels in height.**  

In interlaced projects, this value refers to the fields (playback).  
During playback, the value of this variable is therefore only half of the total height of the frame.  
When Playback is stopped, however, Lightworks internally processes the entire frame as in non-interlaced projects,  
so in this case the number of pixels of the entire frame is output.  

To avoid this, use the following macro:
``` Code
#define OUTPUT_HEIGHT (_OutputWidth / _OutputAspectRatio)
```
If you need the value of the frame height, use OUTPUT_HEIGHT instead of _OutputHeight. If you don't do something like that you can get unexpected results in interlaced projects.

---

In other cases, we may want to calculate dimensions or positions in the sub-pixel area.  
For example, the pixel / texel center, texel edges, Texel dimensions, or / and pixel interpolation.
In these cases, it may be correct to use the original variable `_OutputHeight`.
This must be checked in each case.
