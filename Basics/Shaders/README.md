# Shaders

### Example of a simple shader
This code reflects the texture along the x-axis. (as well as the Lightworks "Flop" effect):
``` Code
float4 ps_main (float2 uv : TEXCOORD1) : COLOR 
{ 
   float2 xy = float2 (1.0 - uv.x, uv.y);
   return tex2D (InputSampler, xy); 
}
```

### Name of the Pixel Shaders:  

We recommend using the prefix **`ps_`** for each shader, which makes it clear what it is.  
In the example above **`ps_main`**.  
Note: This name must also be entered outside the shader in the corresponding entry in the "Techniques" section.  

---

### Texture coordinates:

`float4 ps_main **`(float2 uv : TEXCOORD1)`** : COLOR`

The **`(float2 uv : TEXCOORD1)`** inside the parenthesis defines **`uv`** to be the coordinates of the texture.   
This float2 variable contains the components `x` and `y` that determine the position of the output texel to be calculated.  
Because the texture consists of many texels, uv will assume different values.  
 **`(float2 uv: TEXCOORD1)`** causes the GPU to do this fully automatically.  

**[more details](TEXCOORD.md)**  

--- 

### Description of the above example code:

`   float2 (1.0 - uv.x, uv.y);`




---
---

### Take parameters from the "Technique":

*jwrl wrote:*
[...] you can also pass parameters other than texture coordinates to your shaders.  
Here's an example from my SuperBlur effect.  
This does five passes through the same shader, each time with different parameters.  
``` Code
float4 ps_main (float2 uv : TEXCOORD1, uniform sampler blurSampler, uniform float blurRadius) : COLOR
```
For more information see [lwks.com post # 147395 on page 5](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=60&Itemid=81#147395)

--- 

### Programming and GPU load or shader limits:


*jwrl wrote:*
> Also conditional statements aren't particularly efficient. 
>They will always carry out both branches of the condition, then discard the result they don't need. 
>For this reason I will usually try and structure them so that I can force an exit as the sole result of the true condition. 
>In normal programming this is definitely not the best practice, but here it's a good idea if you can do it. 
>It also means that there is no else condition.  

 >Finally loops will always be unrolled at compile time at least in the Windows compiler. 
 >I'm unsure about that for the other two. This has implications for just how much you can build into a loop.



