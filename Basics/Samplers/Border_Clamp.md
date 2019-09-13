## Sampler setting: Horizontal Border and vertical ClampToEdge 


**Compatibility**: 
- **ClampToEdge:** >= Lightworks 14.5
- **Address Border:**  Unfortunately, no details are documented yet.  
Quote from jwrl:  
>  ..  it behaves differently in Windows and Linux.

----

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
