# Wrapp sampler setting

### Example:
``` Code
sampler WrapSampler = sampler_state
{
   Texture = <In1>;
   AddressU = Wrap;
   AddressV = Wrap;
   MinFilter = Linear;
   MagFilter = Linear;
   MipFilter = Linear;
};
```

### The result:
![](images/Wrap.png)  
[Just for comparison the original texture](images/Original.png)  
