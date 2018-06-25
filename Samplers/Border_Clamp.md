# Sampler setting  
  ## Horizontal Border and vertical Clamp or ClampToEdge

### Clamp (Windows):
``` Code
sampler Border_U_Clamp_V_Sampler = sampler_state
{
   Texture = <In1>;
   AddressU = Border;
   AddressV = Clamp;
   MinFilter = Linear;
   MagFilter = Linear;
   MipFilter = Linear;
};
```

### ClampToEdge (Linux/Mac):
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
![](images/UBorder_VClamp.png .png)  
[Just for comparison the original texture](images/Original.png)  
