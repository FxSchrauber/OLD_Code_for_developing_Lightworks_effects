# Clamp or ClampToEdge sampler setting

### Clamp (Windows):
``` Code
sampler ClampSampler = sampler_state
{
   Texture = <In1>;
   AddressU = Clamp;
   AddressV = Clamp;
   MinFilter = Linear;
   MagFilter = Linear;
   MipFilter = Linear;
};
```

### ClampToEdge (Linux/Mac):
``` Code
sampler ClampSampler = sampler_state
{
   Texture = <In1>;
   AddressU = ClampToEdge;
   AddressV = ClampToEdge;
   MinFilter = Linear;
   MagFilter = Linear;
   MipFilter = Linear;
};
```

### The result:
![](images/Clamp.png)  
[Just for comparison the original texture](images/Original.png)  
