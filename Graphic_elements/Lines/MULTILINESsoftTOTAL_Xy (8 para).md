## MULTILINESsoftTOTAL_Xy (8 parameters)

**Macro call: `MULTILINESsoftTOTAL_Xy (uv , color , bgVariable , lines , lineweight , soft , angle , roll)`**

***Purpose of the macro:***  
Generating a selectable number of **lines** of equal distance across the **entire frame**.  
Optimized for **horizontal lines**; recommended application range 0 to 45°.  
The **angle** can be changed by shifting the right end of the line without changing the position of the left end of the line.  
The **softness of the line edges** can be adjusted.  
The **background texture** is added with the `bgVariable`.  
This can be a color, or a texture from a sampler.  
More functions and details see the parameter descriptions.


---

#### Parameter Description  
  
   1. `uv`:  
     Enter the name of the used texture coordinate variable.  
     *Type:* `float2`  
     Recommendation: float2 uv0 : TEXCOORD0   (which may not be used for sampler parameters!)

---

  
   2. `color`:  
     Color of the line  
     ***Type:*** float3 (RGB) or float4 (RGBA) **but must be the same as** `bgVariable`  
       - (For special purposes, float1 or float2 should also work as long as only one variant is used.) 
  
---

   3. `bgVariable`:  
     The background texture  
     ***Type:*** float3 (RGB) or float4 (RGBA) **but must be the same as** `color`  
       - (For special purposes, float1 or float2 should also work as long as only one variant is used.)  
       
---

   4. `lines`:  
   - Number of lines on the left edge of the frame.  
     Depending on the angle settings, additional lines may be visible beginning at the bottom or top of the frame.  
     This parameter only takes into account lines touching the left edge of the frame.  
    - *Type:* **scalar** `float`  
    - **Impermissible value:** 0 (would be a division by zero within the macro)  

---

   5. `lineweight`:  
     - Line width  
     - *Type:* **scalar** `float`  
     - Usable value range 0.0 to 0.5  
     - Examples (horizontal lines without edge softness):  
       0.000:  Line width 0 pixels  
       0.005: Line width 1% of the frame hight  
       0.500: Line width over the entire frame height 
     - If the angle of the lines is not horizontal, then the lines move closer together,  
       because additional lines on the top or bottom edge of the frame fill the vacant areas.  
       The ratio of the line width to the width of the intervening background remains approximately constant. 
       As a result, the line width becomes narrower than the set value.
     - A set edge softness increases the line width.
         
---

   6. `soft`:
     - Edge softness of the lines.  
     - *Type:* **scalar** `float`  
     - Usable value range ~ 0.0001 to 0.5  
     - **Impermissible values:** 0 (would be a division by zero within the macro)  
     - Examples (horizontal lines):  
       0.0001: No softness  
       0.005: Softness 1% of the frame hight  
     - Softness increases the line width. This can far exceed the set line width.   
     - The maximum softness is achieved when, with the line width parameter set to zero,   
       the width is set only with the softness parameter.  
     - Recommended minimum settings to minimize pixel jumps and aliasing:

  | PAL / NTSC |   720p |  1080p |  UHD  |
  |:----------:|:------:|:------:|:-----:|
  |    35E-4   | 14E-4  |  9E-4  | 5E-4  |
  
...
  
   6. `soft` **Different requirements** for this parameter when using the **alternative macro code**:  
     - Usable value range 0.0 to 0.5  
     - **Impermissible values:** Negative values (risk of divide by zero within the macro)  
     - A value of 0.0 automatically applies a minimum edge softness of 1 texel (interlaced projects 2 texel).  
       This applies to the 0 ° angle setting. At angles of 45 ° or more, additional edge softness may be required.



---

  7. `angle`:
    - The **angle** can be changed by vertically shifting the right end of the line  
      without changing the position of the left end of the line.  
    - *Type:* **scalar** `float`  
      0.0 Horizontal line  
      +1.0 : 45° (lines rising from left to right)  
      -1.0 : 45° (lines falling from left to right)  
      The adjustment characteristic is not linear.
      0.18 : ~ 10°  
      0.37 : ~ 20°  
      0.58 : ~ 30°  
      0.84 : ~ 40°  
      1.00 : = 45°  
      1.19 : ~ 50°  
      1.74 : ~ 60°  
      2.73 : ~ 70°  
      5.70  : ~ 80°  
      There are no 90 ° adjustable  
      For values well above 45 ° another macro is recommended: (MULTILINESsoftTOTAL_**Yx**) 
    - This parameter also affects the line width.    

---
   
   6. `roll`:
     - This rolls the lines in the 90 ° direction to the line. 
     - Rising values of `roll` roll all lines down, sinking values up (if an angle of 0° is set).
     - *Type:* **scalar** `float`  
     - Usable value ranges:  
       - To position the first line within the texture (which is the only one independent of the number of lines): from 0 to 1  
       - Rolling of the lines (keyframing): ~ -1000 to + 1000  
         (if this range is exceeded, the mathematical unrealities can be seen.)  

---

 #### Return value:
   - The value of the parameter `color` (the line)  
      or the value of the parameter`bgVariable`  
      or a mix of both (edge softness)  
   - *Type:* same as `color` and `bgVariable`  
     When used for line generation: float3 (RGB) or float4 (RGBA)
   - *Value range*: 0.0 to 1.0  

 
---
---


### Environment requirements

#### Global variable:
  float `_OutputAspectRatio`

---


#### Macro code:

```` Code
#define MULTILINESsoftTOTAL_Xy(uv, color,bgVariable,lines,lineweight,soft,angle,roll)               \
   lerp (color, bgVariable,                                                                         \
      saturate  (                                                                                   \
         (abs( (uv.y - (roll + uv.x * _OutputAspectRatio * angle))                                  \
            - (round( (uv.y  - (roll + uv.x * _OutputAspectRatio * angle ))  * lines)  / lines ))   \
         - lineweight                                                                               \
         )                                                                                          \
         /  soft                                                                                    \
      )                                                                                             \
   )
````      

---

#### Alternative macro:
 ( with automatic minimum edge softness)
  

#### Global variable:
  `float  _OutputHeight, _OutputAspectRatio`   


#### alternative Macro code:
  
```` Code
#define MULTILINESsoftTOTAL_Xy(uv, color,bgVariable,lines,lineweight,soft,angle,roll)               \
   lerp (color, bgVariable,                                                                         \
      saturate  (                                                                                   \
         (abs( (uv.y - (roll + uv.x * _OutputAspectRatio * angle))                                  \
            - (round( (uv.y  - (roll + uv.x * _OutputAspectRatio * angle ))  * lines)  / lines ))   \
         - lineweight                                                                               \
         )                                                                                          \
         /  (soft + (1.0 / _OutputHeight))                                                          \
      )                                                                                             \
   )
````

`(1.0 / _OutputHeight` is the height of a texel within the output texture.  
This creates the necessary edge softness of the lines.

The use of `_OutputHeight` is controversial because in interlaced projects this variable has a different value
during playback than when playback is stopped.  
In this macro, this means that while the playbacks in interlaced projects, the edge softness of the lines is doubled.
This may be desirable in the case of very narrow lines, because otherwise the position-dependent variations line width
will be visible by one pixel. In the case of moving line positions using keyframing, this also minimizes the flickering
of the lines in interlaced projects.
  
