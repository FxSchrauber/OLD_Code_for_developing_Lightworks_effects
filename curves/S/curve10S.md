# This page is still under construction !!
# curve10S 
![](img/curve10S.png)   
  
  ---
    
### Required global definitions and declarations:
*(add outside and above all shaders and functions):*
```` Code
//--------------------------------------------------------------//
// Definitions, declarations und macros
//--------------------------------------------------------------//

#define TANH(value)    tanh (clamp ( value , - 9.0 , 9.0))
````
This definition avoids critical values. See the [documentation of tanh.](../../Basics/Functions/Cg_standard_library/tanh/README.md#critical-parameter-values)  

---
  
### Code (Example as a function):  
```` Code
float fn_curve10S (float x, float steepness)
{
   x = x * 2.0 - 1.0 ;                                 //  _Progress 0 ... 1  auf progress -1 ... +1
   x = TANH ( x * steepness );                         //  S-Kurve, positiv und negativ
   return x / 2.0 + 0.5;                              // skalierung auf  0 zu 1
}
````
---
  
### Parameter Description:
    
1. `x`: The value to apply the S-curve to.
   - **Type:** `float`, local   
   - **Value range**: Designed for a range of **0.0 to 1.0** , but all other values are allowed.
   - **Center** of the S-curve (return value identical to `x`): **0.5**   

2. `steepness`: steepness of the S-curve 
   - **Type:** `float`, local   
   
---
  
## Return value: 
   - **Value range**: 0 to 1 or narrower 
   - **Type:** `float`


