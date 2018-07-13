# Shaders


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




