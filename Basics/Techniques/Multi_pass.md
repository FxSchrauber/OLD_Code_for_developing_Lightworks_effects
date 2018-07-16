# Multi pass

Here is a simplified example with two active pixel shaders:  
![](images/multipass01.png)  
``` Code
technique Shear
{
   pass P_1
   <
      string Script = "RenderColorTarget0 = OutputFromPassOne;";
   > 
   {
      PixelShader = compile PROFILE ps_ShearHorizontal();
   }

   pass P_2
   {
      PixelShader = compile PROFILE ps_ShearVertical();
   }
}
```

To make the textures available to the pixel shaders, we still have to create the [Inputs](../Inputs.md ) and [Samplers](../Samplers/README.md ). In order for it to be compiled, all import code and sampler code must be above the pixel shader and the technique:
![](images/multipass02.png )

The intermediate target of the texture "OutputFromPassOne" could also get a different name, which must match in the sections Techniques, [Inputs](../Inputs.md ) and  the [Sampler settings](../Samplers/README.md ).


You can also use multiple texture targets with different names. You can make these textures available to one or more pixel shaders via different samplers. This allows you to create a complex routing within the effect with pixel shaders, similar to the routing we already know from Lightworks with different effects.
