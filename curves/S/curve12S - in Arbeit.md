# This document is currently under construction!

# curve12S 
- S-curve with adjustable slope based on tanh. 
- Automatic re-scaling of the TANH return values to ensure that the S-curve starts and ends with saturated levels (0 or 1).
![](img/curve12S.png)   
  
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
float fn_curve12S (float x, float slope)
{
   slope = (slope < 0.0) ?  min(slope , -0.03) : max(slope , 0.03 );             // verhindert zu kleine absolute Werte, welche zu ungenauen bzw. unerwarteten Rückgabeweterten führen könnten.
   x = x * 2.0 - 1.0 ;                                             //  _Progress 0 ... 1  auf progress -1 ... +1

   float sCurve  = TANH ( slope * x );         //  S-Kurve, positiv und negativ

   float refLevelA = abs (TANH (slope * -1.0));                    // Referenzpegel bei progress-Anfang  ,  -1.0 ist progress-Anfang
   float refLevelB = abs (TANH (slope));                           // Referenzpegel bei progress-Ende

   float levelCorrection1 = 1.0 / max(refLevelA, 1E-9);                   // Erforderliche umskalierung der S-Kurve auf den gewünschen Maximalwert abs 1 am Progress-Anfang
   float levelCorrection2 = 1.0 / max(refLevelB, 1E-9);                   // Erforderliche umskalierung der S-Kurve auf den gewünschen Maximalwert abs 1 am Progress-Ende

   sCurve *=  min (levelCorrection1, levelCorrection2) ;

   return sCurve / 2.0 + 0.5;                              // skalierung auf  0 zu 1
}
````
**Description:**  
`x = x * 2.0 - 1.0;` Rescaling of the presupposed value range (0 .. 1) to the range required for tanh from (-1 ... +1)  
`x = TANH ( x * slope );` S-curve, negative and positive values.  Note that TANH is the macro described above.  
`return x / 2.0 + 0.5;` Rescaling the range to 0 .. 1

---
  
### Parameter Description:
    
1. `x`: The value to which the S curve is to be applied.
   - **Type:** `float`, local   
   - **Value range**: Designed for a range of **0.0 to 1.0** , but all other values are allowed.
   - **Center** of the S-curve (return value identical to `x`): **0.5**   

2. `slope`: Slope in the center of the S-curve
   - **Type:** `float`, local   
   
---
  
### Return value: 
   - **Value range**: 0 to 1  (see graphics above)
   - **Type:** `float`
   
---
---

### Alternative code:

Under the following conditions, the macro `TANH` can alternatively be replaced by `tanh` (Macro not required):  
   The function is called with parameter values within the following range:  
   - `x` Maximum range 0 to 1  
   - `slope` Maximum range about -9 to +9  
    
If the macro`TANH` is used, these restrictions do not apply!  

