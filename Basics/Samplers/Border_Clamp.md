## Sampler setting: Horizontal Border and vertical ClampToEdge 
**>= Lightworks 14.5**

``` Code
sampler Border_U_Clamp_V_Sampler = sampler_state
{
   Texture = <In1>;
   AddressU = Border;
   AddressV = ClampToEdge;
   MinFilter = Linear;
   MagFilter = Linear;
   MipFilter = Linear;
};
```

### The result:
![](images/UBorder_VClamp.png)  
[Just for comparison the original texture](images/Original.png)  
