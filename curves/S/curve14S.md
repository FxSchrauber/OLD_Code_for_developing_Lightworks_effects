# curve14S


- S-curve with adjustable slope based on tanh. 
- Adjustable X-position of the S-curve.  
- In the case of a centred X-position of the S-curve, it is ensured  
  that the curve begins and ends with saturated values (0 and 1).
   - For other x-positions this depends on the position, and the steepness of the curve (see images).

## Image has yet to be created!
![](img/curve14S.png)  
  
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
float fn_curve14S (float x, float slope, float pan)
{
   float x2 = (x * 2.0 - 1.0) - pan;
   float sCurve  = TANH ( slope * x2 );

   float refLevel = abs (TANH (slope));
   float levelCorrection = 1.0 / max(refLevel, 1E-9);
   sCurve *= levelCorrection  ;

   sCurve = slope < 0.4 ? lerp ( sCurve, x2 , (0.4 - slope) * 2.5) : sCurve;
   return saturate (sCurve / 2.0 + 0.5);
}

````

**Description:**  
      
   - `float x2 = (x * 2.0 - 1.0) - pan`  
      Rescaling of the presupposed value range (0 .. 1) to the range required for tanh from (-1 ... +1); and `- pan` 
   - `float sCurve  = TANH ( slope * x2 );`  
      S-curve, negative and positive values. Note that TANH is the macro described above.  
   - `float refLevel = abs (TANH (slope));`  
      - Functionally identical, longer code `float refLevel = abs (TANH (slope * 1.0));`
      - Reference level at the end of the curve (x = 1.0). 
   - `float levelCorrection = 1.0 / max(refLevel, 1E-9);`  
      Factor by which the S-curve must be scaled so that the respective ends result in -1 or +1.  
      `max(refLevel, 1E-9)` prevents a division by zero.
   - `sCurve *= levelCorrection;`  Rescaling the S-curve so that the value at the respective ends of the S-curve is -1 or +1.
  - `return slope < 0.4 ? lerp ( sCurve, x2 , (0.4 - slope) * 2.5) : sCurve;`  
    This code reduces mathematical inaccuracies when `slope` values are set close to 0.  
    At `slope` 0, the values of the variable `sCurve`, before rescaling, are a horizontal line with the value 0.  
    However, the previous code `sCurve *= min (levelCorrection1, levelCorrection2)`  
    tries to multiply the value 0 extremely to produce a curve (ramp) from -1 to +1.  
    Because this is impossible, the value `x2` is used instead:  
    With `slope` values of zero, `x2` is used as the `sCurve` value.  
    With positive `slope` values of >=0.4 , the previously calculated sCurve value is used.  
    With `slope` 0.2 the values of the sCurve and `x2` are mixed in equal proportions.  
    - `(0.4 - slope) * 2.5)` defines the mixing ratio.  
      - If `slope` has the value 0.4, then the formula results in the control value 1.0, 
      whereby `lerp` is used only the previously calculated sCurve value.  
       - If `slope` has the value 0.0, then the formula results in the control value 1.0, 
      whereby `lerp` will only use `x2`, which is already flattened at this value so 
      that it is very similar to the value `x2`.  
       - Negative `slope` - values are not allowed. (negative values only generated a simple ramp with higher slope than the S-curve for the GPU used for the test)
  - `return saturate (sCurve / 2.0 + 0.5)` Rescaling the range to 0 .. 1  
    `saturate` prevents the start or end of a flat curve leaving the range from 0 to 1 at `pan` <> 0.


---
  
### Parameter Description:
    
1. `x`: The value to which the S curve is to be applied.
   - **Type:** `float`, local   
   - **Value range**: Designed for a range of **0.0 to 1.0** , but all other values are allowed.
   - **Center of the S-curve** adjustable

2. `slope`: Slope in the center of the S-curve  
   - Negative values are **not** allowed.
   - **Type:** `float`, local   

3. `pan`: Changing the x-position of the S-curve
   - Centered when `pan` is set to 0
   - If `pan` = -1 is used, the center of the S-curve is moved to the left edge.
   - If `pan` = +1 is used, the center of the S-curve is moved to the right edge.
   
---
  
### Return value: 
   - **Value range**: maximum 0 to 1 (if pan = 0) 
   - **Type:** `float`

   
