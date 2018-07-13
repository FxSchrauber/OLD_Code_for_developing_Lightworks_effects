# Texture coordinates:

*Quote, [redsharknews.com](https://www.redsharknews.com/technology/item/221-how-to-write-video-effects-for-lightworks):*  
``` Code
    float4 ps_main( float2 xy1 : TEXCOORD1 ) : COLOR
``` 
>The “float2 xy1 : TEXCOORD1” inside the parenthesis defines “xy1” to be the coordinates of the texture.  

#### If the effect has more inputs (Example with two inputs):
``` Code
    float4 ps_main (float2 xy1 : TEXCOORD1, float2 xy2 : TEXCOORD2) : COLOR
```

**`TEXCOORD1`** receives the pixel coordinates from the first input.  
**`TEXCOORD2`** is assigned to the second input.  
**`TEXCOORD3`** is assigned to the third input.  
etc.  
Input 1 is the first input you declared in the "Inputs" section (outside the shader).  
The second declared entry is the number 2, etc.  
*Note: Only textures that are visible as input in video routing are considered.  
Internal textures that are rendered only within the effect and sent to a sampler can not be used as a source for texture coordinates.*
  
#### Special case:
**`TEXCOORD0`** is not assigned to an input.  
This can be used when calculating and positioning graphical elements (such as lines) within the shader itself.  

The values of **`TEXCOORD0`**, or position calculations based on them, should **not be used for the sampler coordinates**.
At least not uncorrected under Windows.
The reason, *Great White wrote:*
>Lightworks always arranges for texcoord0 to be in the range 0..1, whereas texcoord1 and above are modified
>to include the necessary half texel adjustments that you need for DirectX (when running on Windows).  

This can lead to pixel shifts in certain areas.
In the case of rendering with TEXCOORD0, this inaccuracy can worsen the result with each pass. 

#### There are test effects that perform a correction calculation.
Apparently, this correction may not or otherwise be applied to Linux & Mac systems.  
If you would like to help find a solution for these special cases, then install the 
[current test effect and report on your results.](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=179224&Itemid=81)
