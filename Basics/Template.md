# Here is a template for creating effects.:
 It shows a program structure that you can complete with your Code.  
 
 jwrl wrote:
 > There's one other thing that I do. I have saved a template file for creating effects.
 > It's undergone some modification since I started doing this, but here's the current version.  
 
 ``` Code
 //--------------------------------------------------------------//
// Lightworks user effect MyEffect.fx
//
// Created by LW user whoever [DATE]
//
//    ***  PLACE THE DESCRIPTION HERE  ***
//--------------------------------------------------------------//

int _LwksEffectInfo
<
   string EffectGroup = "GenericPixelShader";
   string Description = "...";
   string Category    = "...";
   string SubCategory = "...";
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
   pass pass_one
   {
      PixelShader = compile PROFILE ps_main ();
   }
}
```  
> I'm not suggesting for one moment that this should be slavishly copied by anyone writing FX files. It's just what I do....
