# Special auto-synced parameters and definitions
Lightworks provides the following variables, automatically updated by the CPU, for use in effects (GPU).
To use these variables, they must be declared outside and above all shaders and functions. Then these variables with the autumatic values are available globally for the whole effect.
``` Code
//--------------------------------------------------------------//
// Definitions, declarations und macros
//--------------------------------------------------------------//

float _Progress;
float _OutputWidth;
float _OutputHeight;
float _OutputAspectRatio;
float _OutputFPS;
float _Length;
float _LengthFrames;
```
  
---
  
## Descriptions:
  
### Basic variables:

`float _Progress;`          // Relative position in effect progress 0 to 1. Please note some peculiarities: [Details](_Progress.md)  
`float _OutputWidth;`       // The width of the current output format in pixels  
`float _OutputHeight;`      // Please note some peculiarities: [Details](_OutputHeight.md)  
`float _OutputAspectRatio;` //The aspect-ratio of the current output format  


### Starting with Lightworks 14.5 is also available: 

`float _OutputFPS;`     //  eg. 24.0, 25.0, 29.97, etc  
`float _Length;`        // Length of the effect in sec. Please note some peculiarities: [Details](_Length.md)  
`float _LengthFrames;`  // Length of the effect in frames. Please note some peculiarities: [Details](_Length.md)  


---
---

## Preprocessor, predefined (starting with Lightworks 14.5):

To avoid unexpected results when using older versions of Lightworks,  
the availability of variables can now be checked (LW 14.5).  
Each definition shares the same name as its associated parameter, but is in upper case:  
``` Code
_OUTPUTFPS
_OUTPUTASPECTRATIO
_LENGTH
_LENGTHFRAMES
_OUTPUTWIDTH
_OUTPUTHEIGHT
_PROGRESS
```
In general, only one of the new variables need to be checked.  
If, for example, _LENGTH is defined, then all variables are available, otherwise only the basic variables. 
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

[Example Code](../../Auto-synced_parameters/README.md)

More ideas and Discussions:  
[www.lwks.com start from page 8](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=105&Itemid=81#ftop) below of this thread and continue on the following pages.
