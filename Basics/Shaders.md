# Shaders


### Name of the Pixel Shaders:  

*jwrl wrote:*  
>I also prefix any [...] shaders with ps_ so that it's immediately clear what's going on. [...]  
Example: float4 *`*ps_main`**  
Note: This name must also be entered outside the shader in the corresponding entry in the "Techniques" section.  

---

### Texture coordinates:

*Quote, [redsharknews.com](https://www.redsharknews.com/technology/item/221-how-to-write-video-effects-for-lightworks):*  
>**`float4 ps_main( float2 xy1 : TEXCOORD1 ) : COLOR`**  
>The “float2 xy1 : TEXCOORD1” inside the parenthesis defines “xy1” to be the coordinates of the texture.  

#### If the effect has more inputs:  

Example with two inputs: `float4 ps_main (float2 xy1 : TEXCOORD1, float2 xy2 : TEXCOORD2) : COLOR`  

**`TEXCOORD1`** receives the pixel coordinates from the first input.  
**`TEXCOORD2`** is assigned to the second input.  
**`TEXCOORD3`** is assigned to the third input.  
etc.  
Input 1 is the first input you declared in the "Inputs" section (outside the shader).  
The second declared entry is the number 2, etc.  
*Note: Only textures that are visible as input in video routing are considered.  
Internal textures that are rendered only within the effect and sent to a sampler can not be used as a source for texture coordinates.*
