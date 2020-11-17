# Special auto-synced parameters and definitions
Lightworks provides the following variables, automatically updated by the CPU, for use in effects (GPU).
To use these variables, they must be declared outside and above all shaders and functions. Then these variables are globally available with the automatic values for the entire effect.
``` Code
//--------------------------------------------------------------//
// Definitions and declarations
//--------------------------------------------------------------//

float _Progress;  
float _OutputAspectRatio;  
float _OutputHeight;  
float _OutputWidth;  

float _Length;
float _LengthFrames;
float _OutputFPS;

float _FgWidthNormalised;    // "Fg" stands as an example for the name of the input (replace if different). 
float _FgHeightNormalised;   // Replace "Fg" if different.
float _FgWidth;              // Replace "Fg" if different.
float _FgHeight;             // Replace "Fg" if different.
float _FgXScale;             // Replace "Fg" if different.
float _FgYScale;             // Replace "Fg" if different.
```
  
---
  
## Descriptions:
  
### Basic variables:

`float _Progress;`          // Relative position in effect progress 0 to 1. Please note some peculiarities: [Details](_Progress.md)  
`float _OutputAspectRatio;` // The aspect-ratio of the current output format  
`float _OutputHeight;`      // Please note some peculiarities: [Details](_OutputHeight.md)  
`float _OutputWidth;`       // The width of the current output format in pixels  
 

### Starting with Lightworks 14.5 is also available: 

`float _Length;`        // Length of the effect in sec. Please note some peculiarities: [Details](_Length.md)  
`float _LengthFrames;`  // Length of the effect in frames. Please note some peculiarities: [Details](_Length.md)  
`float _OutputFPS;`     //  eg. 24.0, 25.0, 29.97, etc  
  
  
### Starting with Lightworks 2021.1 is also available: 

[Great White reported](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=12&id=228948&Itemid=81#229128)

> If you have an input called 'Fg', then Lightworks will attempt to supply:

`float _FgWidthNormalised;`   // width of image of the "Fg" input divided by width of node output format  
`float _FgHeightNormalised;`  // height of image of the "Fg" input divided by width of node output format  
`float _FgWidth;`             // width of image of the "Fg" input in pixels  
`float _FgHeight;`            // height of image of the "Fg" input in pixels  
`float _FgXScale;`            // scaling factor of the "Fg" input (eg. due to wide/narrow settings)  
`float _FgYScale;`            // scaling factor of the "Fg" input  
For inputs with other names, replace "**Fg**" with the name of the input.


---
---

## Preprocessor, predefined (starting with Lightworks 14.5):

To avoid unexpected results when using older versions of Lightworks,  
the availability of variables can now be checked (LW 14.5).  
Each definition shares the same name as its associated parameter, but is in upper case:  
``` Code
_PROGRESS
_OUTPUTASPECTRATIO
_OUTPUTHEIGHT
_OUTPUTWIDTH

_LENGTH
_LENGTHFRAMES
_OUTPUTFPS

```
For example, if _LENGTH is not defined, then only the basic variables are available.
``` Code
#ifdef _LENGTH
   // Insert code
#else
   // Insert code
#endif
```

---

### Check on which operating system the effect is used:
``` Code
WINDOWS
OSX
LINUX
```
These are already defined outside of the effect, but not on Lightworks versions before LW14.5  
Example of a platform analysis:
``` Code
#ifdef WINDOWS
   // Insert code
#else
   // Insert code
#endif
```

[Example Code](../../../Auto-synced_parameters/README.md)

More ideas and Discussions:  
[www.lwks.com start from page 8](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=105&Itemid=81#ftop) below of this thread and continue on the following pages.
