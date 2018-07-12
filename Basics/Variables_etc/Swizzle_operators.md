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

---


### Another example with rgba values, in which the xywz form is preferable.


 Instead of: `#define BLACK   float4 (0.0, 0.0, 0.0, 1.0)`  

... we can also write: `#define BLACK   float4 (0.0.xxx,1.0)`  

 0.0 is assigned to `x`  
`.xxx` causes the `xyz` to take the value of `x`  
 1.0 is assigned to `w`  

 We could have written `0.0.rrr`, but what could be confusing because only one value corresponds to the color red.  


 A variant which causes the compiler to treat float2 as float4: 
 ``` Code
    #define BLACK   float2 (0.0,1.0).xxxy
```
0.0 is assigned to `x`  
In the first step, 1.0 is still assigned to `y` (without consideration of the Swizzle operator)  
`.xxxy` causes the `xyz` to take the value of `x`, and w take the value of `y`  

---  

### For more information see:
[lwks.com Post #146013 on page 4](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=45&Itemid=81#146013)  

and [lwks.com Post #148433 on page 5](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=60&Itemid=81#148433)
