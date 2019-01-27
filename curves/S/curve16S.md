# curve16S

- S-curve with adjustable slope based on tanh. 
- Adjustable X-position of the S-curve.
- Similar functionality as curve14S, but:  
   - It is ensured that the curve begins and ends with saturated values (0 and 1).
   - This automatic correction may make the curve steeper than originally set. 
     If the curve position is shifted, this automatic correction can also bring the original S-curve closer to a ramp shape. 
     This can be seen in the [video](video/curve16S.mp4).  

## Image has yet to be created!
![](img/curve16S.png)  
  
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
float fn_curve16S (float x, float slope, float pan)
{
   float x2 = (x * 2.0 - 1.0) - pan;
   float sCurve  = TANH (slope * x2);

   float refLevelA = abs (TANH (slope * (-1.0 - pan))); 
   float refLevelB = abs (TANH (slope * (1.0 - pan)));

   float levelCorrection1 = 1.0 / max(refLevelA, 1E-9);
   float levelCorrection2 = 1.0 / max(refLevelB, 1E-9);
   sCurve *=  max (levelCorrection1, levelCorrection2);
   
   float x3 = x2 * (1.0 / max ( (1.0 - abs(pan)), 1E-9) );
   sCurve = slope < 0.4 ? lerp ( sCurve, x3, (0.4 - slope) * 2.5) : sCurve;
   return saturate (sCurve / 2.0 + 0.5);
}

````

**Description:**  
      
   - `float x2 = (x * 2.0 - 1.0) - pan`  
      Rescaling of the presupposed value range (0 .. 1) to the range required for tanh from (-1 ... +1); and `- pan` 

   - `float sCurve  = TANH ( slope * x2 );`  
      S-curve, negative and positive values. Note that TANH is the macro described above.  

   - `float refLevelA = abs (TANH (slope * (-1.0 - pan)));`  Reference level at the start of the curve.  
      - `-1.0` is the starting point of the centered curve.  
      - `pan` calculates the shifted starting point.
       
   - `float refLevelB = abs (TANH (slope * (1.0 - pan)));` Reference level at the end of the curve. 
      - `-1.0` is the starting point of the centered curve.  
      - `pan` calculates the shifted starting point.
  
   - `float levelCorrection1 = 1.0 / max(refLevelA, 1E-9);`  
      Factor by which the S-curve must be scaled so that the S-curve starts with the value -1.   
      `max(refLevel, 1E-9)` prevents a division by zero.  
  
   - `float levelCorrection2 = 1.0 / max(refLevelB, 1E-9);`  
      Factor by which the S-curve must be scaled so that the S-curve ends with the value 1.  

   - `sCurve *= min (levelCorrection1, levelCorrection2) ;`  
     Rescaling the S-curve so that the value at the S-curve starts with the value -1, and ends with the value +1.  

   - `float x3 = x2 * (1.0 / max ( (1.0 - abs(pan)), 1E-9) );`  
     `x3` is an automatically variable ramp which is used in the following code line 
     to increase the precision of the curve values at very low `slope` values.
     - `(1.0 - abs(pan))` Rescaled absolute `pan` value
        - results in value 1 with centred curve
        - results in the value 0 for `pan` = 1
     - `max (` and  `, 1E-9)` prevents a division by zero.
     - `(1.0 / max ( (1.0 - abs(pan)), 1E-9) )`
        - results in value 1 with centred curve
        - results in the value 2 for `pan` = 0.5
        - results in the value 1E9 for `pan` = 1
     - `x2` is the base ramp from -1 to +1
     - `x2 * (1.0 / max ( (1.0 - abs(pan)), 1E-9) );`  
       Changes the ramp slope depending on the set position of the S-curve.
        - Unchanged with centered curve (`pan` = 0).
        - Double slope at `pan` = 0.5
        - Almost vertical at `pan` = 1

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
       - Negative `slope` - values are not allowed. 
       (negative values only generated a simple ramp with higher slope than the S-curve for the GPU used for the test)
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
   - **Value range**: 0 to <1
      - Centered when `pan` is set to 0
      - If `pan` = -0.5 is used, the center of the S-curve is shifted 25% to the left on the x-axis.
      - If `pan` = +0.5 is used, the center of the S-curve is shifted 25% to the right on the x-axis.
      - Values of -1 or +1 or above usually make no sense, because the automatic level correction increases the slope so 
        that the curve disappears, or leads to a level jump at the X-value 0 or 1 (more precisely 0.000 000 001 or 0.999 999 999).
   
---
  
### Return value: 
   - **Value range**: maximum 0 to 1 (if pan = 0) 
   - **Type:** `float`

   
