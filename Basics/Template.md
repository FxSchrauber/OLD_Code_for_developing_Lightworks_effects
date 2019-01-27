## Here is a template that can make it easier to create an effect:
 It shows the example of a program structure that you can complete with your code. 
 
 
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

//--------------------------------------------------------------//
// Inputs
//--------------------------------------------------------------//

...

//--------------------------------------------------------------//
// Samplers
//--------------------------------------------------------------//

...

//--------------------------------------------------------------//
// Parameters
//--------------------------------------------------------------//

...

//--------------------------------------------------------------//
// Definitions and declarations
//--------------------------------------------------------------//

...

//--------------------------------------------------------------//
// Functions
//--------------------------------------------------------------//

float2 fn_some_func (...)
{

...

}

//--------------------------------------------------------------//
// Shaders
//--------------------------------------------------------------//

float4 ps_main (...) : COLOR
{

...

}

//--------------------------------------------------------------//
// Techniques
//--------------------------------------------------------------//

technique MyEffect
{
   pass P_1
   {
      PixelShader = compile PROFILE ps_main ();
   }
}
```  

