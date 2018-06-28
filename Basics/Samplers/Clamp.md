# ClampToEdge sampler setting
 **>= Lightworks 14.5**  
(Only backwards compatible on Linux & Mac) 
     
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

---

#### Clamp (Windows):

Great White wrote:
> ... the root problem is in the use of "Clamp" for the sampler states AddressU/AddressV in dve1.fx. 
> It appears that "Clamp" means distinctly different things in Microsoft/HLSL and Cg (Mac/Linux). 
> 
> To get the right/expected answer with Cg, we need to use ClampToEdge (not Clamp). 
> I've modded all our affected shaders accordingly (and added a #define for ClampToEdge=Clamp when running on Windows).
