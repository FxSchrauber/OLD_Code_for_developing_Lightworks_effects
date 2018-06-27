
# Border sampler setting

### Example:
``` Code
sampler BorderSampler = sampler_state
{
   Texture = <In1>;
   AddressU = Border;
   AddressV = Border;
   MinFilter = Linear;
   MagFilter = Linear;
   MipFilter = Linear;
};
```

### The result:
![](images/Border.png)  
[Just for comparison the original texture](images/Original.png)  
