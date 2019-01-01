# progressCos1_0_1  
![](images/progressCos1_0_1.png)  
Three-point progress: 1 .. 0 .. 1  
  
*Required global variable declaration and definition (add outside and above all shaders and functions):*
```` Code
//--------------------------------------------------------------//
// Definitions and declarations
//--------------------------------------------------------------//

#define TWO_PI  6.2831853072
float _Progress;
````  
  
### Local Code (within shaders or functions):  
```` Code
float progressCos1_0_1 = cos(_Progress * TWO_PI) * 0.5 + 0.5;
````
  
### Parameter Description:
1. [Documentation of the variable `_Progress`](_Progress.md)  
2. **TWO_PI**: Defines the wavelength as one complete wave.  
   Higher values shorten the wavelength (more waves per effect runtime)  
 3. `* 0.5` Scales the original value range (-1 to +1) to -0.5 to +0.5
 4. `+ 0.5` Moves the wave in the positive range.
