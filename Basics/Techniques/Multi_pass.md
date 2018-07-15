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

To make the textures available to the pixel shaders, we still have to create the inputs and samplers:  
![](images/multipass01.png )

![](images/multipass02.png )
