# linePatternD02  [![](../images/linePatternD02-thumb.png)](../images/linePatternD02.png)

**Function call:** `fn_linePatternD02 (uv, color1, color2, number, edgeSharpness);`  

Example with values: `fn_linePatternD02 (uv, float3(0.1, 0.1, 0.4), float3(0.9, 0.3, 0.0), 20.0, 1000.0);`  
(Result [see image](../images/linePatternD02.png))
  
--- 
  
***Purpose:***  
Creates a pattern of a selectable number of symmetrical diagonal 45° lines  
of alternating color or brightness or another RGB source.     
This can be a color, or a texture from a sampler.  
Adjustable edge softness of the squares.   
More details see the parameter descriptions.  

---
    
### Required global definitions and declarations:
*(add outside and above all shaders and functions):*
```` Code
//-----------------------------------------------------------------------------------------//
// Definitions and declarations
//-----------------------------------------------------------------------------------------//

float _OutputAspectRatio;
#define PI  3.141592654
````
---

### Code (Example as a float3 RGB function without alpha):
```` Code
float3 fn_linePatternD02 (float2 uv, float3 color1, float3 color2, float number, float edgeSharpness)
{ 
   float mix = uv.x - (uv.y / _OutputAspectRatio);
   mix =  sin (mix * PI * number ) * edgeSharpness / number;
   return lerp (color1, color2, clamp( mix, -0.5, 0.5) + 0.5);
}
````   
When making code changes, note that `color1` and `color2` must have the same float type.

[Code description at the bottom of this page.](#code-description)


---
---

### Parameter Description  
  
   1. `uv`:  
     Enter the name of the used texture coordinate variable.  
     **Type: `float2`**  
      

---

  
   2. `color1`:  
     Color of the first square at the top left. 
     **Type: `float3` (RGB)**  
       - This can be a color, or a texture from a sampler.

  
---

   3. `color2`:  
     Color of the squares next to `color1` squares. 
     **Type: `float3` (RGB)**  
       - This can be a color, or a texture from a sampler.  

       
---

   4. `number`:  
     The number of lines of both colors, counted only at the top or bottom edge of the frame.    
     **Type: `float`**  
     Value range: > +1   or < -1  
     **Illegal value is 0** (leads to division by 0)  


---

   5. `edgeSharpness`:  
     Edge sharpness of the squares  
     **Type: `float`**  
     Value range: > +1   or < -1  
     Values around 1000 and above result in relatively sharp edges for HD formats.  
     At 200 and below, the edge smoothness is clearly visible.  


---

### Return value:
   - The value of the parameter `color1` or `color2` (in the change of squares)  
   - **Type: float3** (same type as `color1` and `color2`)    
   - Value range: 0.0 to 1.0  

 
---
---

### Code description  

The code at the top of this page is compressed.  
For a better understanding, the uncompressed code is described here:
```` Code
float3 fn_linePatternD02 (float2 uv, float3 color1, float3 color2, float number, float edgeSharpness)
{ 
   float mix = uv.x - (uv.y / _OutputAspectRatio);
   mix =  sin (mix * PI * number );
   mix *=  edgeSharpness / number;
   mix =  clamp( mix, -0.5, 0.5);      // range -0.5 +0.5
   mix += 0.5 ;                        // range 0 to 1
   return lerp (color1, color2, mix);
}
````
**Code description:**  
 
`float mix = uv.x - (uv.y / _OutputAspectRatio);` This produces a value that is constant in the diagonal direction, 
from bottom right to top left, at a 45 ° angle.
This makes the lines created in the following lines of code diagonal.  

`mix =  sin (mix * PI * number );` Creates a diagonal wave pattern ( value range from -1 to +1).

The following two lines of code increase the sharpness:
```` Code
x *=  edgeSharpness / number;
x =  clamp( x, -0.5, 0.5);   // range -0.5 +0.5`
````
` x += 0.5 ; ` Move to the normal range from 0 to 1  

`return lerp (color1, color2, mix);` Assignment to the set colors.  
If you only need black and white lines then you can simplify the code by returning the `mix` variable.  



---
---
### Screenshot  
![](../images/linePatternD02.png)
