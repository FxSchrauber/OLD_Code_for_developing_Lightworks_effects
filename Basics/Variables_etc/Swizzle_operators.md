# Swizzle operators



*jwrl wrote:*  
> There are two ways that subscripts work with floats in Cg. You can use either rgba notation or xyzw notation.  

> You can regard a float as being an array containing just 1 member, which therefore is referenced by the suffix ".x".  
> In exactly the same way that you can move values in a float4 by typing `newval.xyzw = oldval.zyxw`,  
> you can say `newval.xyzw = oldval.xxxx`  

> You can play all sorts of tricks by doing things like `float2 xy = uv.yx`, which will rotate the image through 90 degrees.  
> You can also do things like `Input.rgb = Input.aaa`, in which case the alpha channel will be shown as a monochrome image.
> That could also be written `Input = Input.aaaa` and achieve the same result [...]  
>  [...] What you cannot do is change the notation with which you refer to a variable. See the example below.

``` Code
   float4 In1 = 1.0;
   float4 In2 = 0.0;

   In2.w = 1.0;
   In1.rgb = In2.rgb     // This will fail!!!  Do not use
```

``` Code
   float4 In1 = 1.0;
   float4 In2 = 0.0;

   In2.w = 1.0;
   In1.rgb = In2.xyz     // This will work
```
> Having the xyzw form available is useful when you're dealing with non-rgba media - HSL, HSV and the like, for example.  

> [...] "non-rgba values" The example that I gave refers to media, but it's actually a more general notation than that.

> [...]  
> In the same way that referring to a position as xy.rg would be confusing, referring to an HSL value as hsl.rgba would also cause confusion.  
> There can be no red, green or blue components of an HSL value, just hue, saturation and luma.  
