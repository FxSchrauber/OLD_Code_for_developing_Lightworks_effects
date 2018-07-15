# Shaders

### Example of a simple shader
This code rotates the texture by 180 °:
``` Code
float4 ps_main (float2 uv : TEXCOORD1) : COLOR 
{ 
   return tex2D (InputSampler, 1.0 - uv); 
} 
```

### Name of the Pixel Shaders:  

**`float4 ps_main`**
We recommend using the prefix **`ps_`** for each shader, which makes it clear what it is.  
In the example above **`ps_main`**.  
Note: This name must also be entered outside the shader in the corresponding entry in the "Techniques" section.  

---

### Texture coordinates:

``` Code
float4 ps_main (float2 uv : TEXCOORD1) : COLOR`
```

The **`(float2 uv : TEXCOORD1)`** inside the parenthesis defines **`uv`** to be the coordinates of the texture.   
This float2 variable contains the components `x` and `y` that determine the position of the output texel to be calculated.  
Because the texture consists of many texels, uv will assume different values.  
 **`(float2 uv: TEXCOORD1)`** causes the GPU to do this fully automatically.  

**[more details](TEXCOORD.md)**  

--- 

### Description of the above example code:

``` Code
    return tex2D (InputSampler, 1.0 - uv);
```

* **`return`** expects a float4 RGBA value, which is returned to the ["Techniques"](../Techniques/README.md ).  
* **`tex2D (`**.. is a function call. This [standard CG function](../Functions/CG_standard_library/README.md) 
                                           is already implemented globally for all effects.  
* **`InputSampler,`**  It is the first parameter passed to the `tex2D` function. The sampler specified here must exist outside the shader, further up in the effect code. This sampler will read and preprocess the RGBA value of a texture.  
* **`1.0 - uv`** The result of this calculation is the second parameter passed to the `tex2D` function and thus also to the sampler. This float2 value tells the samper the sample position. Because this calculation deviates the sampler position from the position of the output pixel, the rotation is achieved at 180 °. This is done by mirroring the texture on both the right and bottom edge of the frame.
   * **`1.0 `** This value corresponds to the right frame edge and the bottom frame edge. [details](TEXCOORD.md#position-on-the-frame)
   * **`- uv`** [For details](#texture-coordinates) about this position variable, see above. 


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



