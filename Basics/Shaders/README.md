# Shaders


``` Code
float4 ps_main (float2 uv : TEXCOORD1) : COLOR 
{ 
   float2 xy = float2 (1.0 - uv.x, uv.y);
   return tex2D (InputSampler, xy); 
}
```

### Name of the Pixel Shaders:  

*jwrl wrote:*  
>I also prefix any [...] shaders with ps_ so that it's immediately clear what's going on. [...]  
Example: float4 *`*ps_main`**  
Note: This name must also be entered outside the shader in the corresponding entry in the "Techniques" section.  

---

### Texture coordinates:
*Quote, [redsharknews.com](https://www.redsharknews.com/technology/item/221-how-to-write-video-effects-for-lightworks):*  
``` Code
    float4 ps_main( float2 xy1 : TEXCOORD1 ) : COLOR
``` 
>The “float2 xy1 : TEXCOORD1” inside the parenthesis defines “xy1” to be the coordinates of the texture.   

**[more details](TEXCOORD.md)**  

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



