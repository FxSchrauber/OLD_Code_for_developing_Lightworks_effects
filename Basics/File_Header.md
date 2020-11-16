## Example of a file header:

``` Code
// @Maintainer [Optional]
// @Released [Required]
// @Author [Required - repeat if more than one author]
// @Created [Required]
// @see [PNG or JPEG screen grab - repeat for more images or MP4 examples of use]

/**
 PLACE DESCRIPTION HERE USING AS MANY LINES AS NECESSARY
*/

//-----------------------------------------------------------------------------------------//
// Lightworks user effect MyEffect.fx
//
// PLACE REVISION HISTORY HERE
//-----------------------------------------------------------------------------------------//

int _LwksEffectInfo
<
   string EffectGroup = "GenericPixelShader";
   string Description = "...";
   string Category    = "...";
   string SubCategory = "...";
   string Notes       = "...";
> = 0;
```
Starting with Lightworks 2021, the use of the original resolution of the input can optionally be activated:  
`   bool CanSize       = true;`  
  
Example:  
``` Code
int _LwksEffectInfo
<
   string EffectGroup = "GenericPixelShader";
   string Description = "...";
   string Category    = "...";
   string SubCategory = "...";
   string Notes       = "...";
   bool CanSize       = true;
> = 0;
```  
Without `CanSize`, the effect uses the resolution that was set in the sequence respectively for the export.  
Optionally, the use of the sequence respectively export resolution can be declared unambiguously:  
`   bool CanSize       = false;`  
  
Note that apart from the GPU load, `bool CanSize = true;` may have other side effects that should be considered in the code.  
For example, if the original aspect ratio differs from the sequence aspect ratio respectively export aspect ratio, then this may require two inputs, so that e.g. when zooming within this effect, the whole export texture can be used. It is not absolutely necessary to use the second texture in the shader, because just the presence of a second input (even if not connected) allows the effect to extend the foreground texture into the whole output texture (of course as before, depending on how the shader code processes the foreground texture). 
