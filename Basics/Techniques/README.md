# Techniques


### The simplest case: Single technique, Single pass

If you are using only a single pixel shaders with one pass, then you can just copy the code from the template:

``` Code
//--------------------------------------------------------------//
// Techniques
//--------------------------------------------------------------//

technique MyEffect
{
   pass P_1
   {
      PixelShader = compile PROFILE ps_main();
   }
}
```

 "My Effect" is just an example, and in this template means the effect name. But it also works different names, or no name.
 See [lwks.com/..page 5 for more information](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=60&Itemid=81#147254)

 Make sure that the name "ps_main" matches the name of the pixel shader.

 If possible, you should not change the word "PROFILE" to get the cross-platform compatibility. 
 If the complexity of your pixel shader gets so high that you get an error message when compiling, 
 try to distribute the task to several pixels shaders (see "Multi pass" below). 
 If this is not possible in exceptional cases, or for test purposes, you can insert "ps_3_0" (shader model 3) 
 instead on Windows computers. But keep in mind the limited usability of your effect. 
 **New from Lightworks 14.5:**  It is now possible within the effect to 
 [test on which operating system the effect is used.](../Variables_etc/Auto_synced/README.md#check-on-which-operating-system-the-effect-is-used) 
 This opens up new possibilities to use ps_3_0 on Windows platforms, without losing the compatibility with Linux and Mac.

*Quote by FxSchrauber*
> Immediately before reaching the performance limit of the Pixel Shader, I noticed in some cases a sudden increase in the GPU load, 
> which was much lower when testing with the Shader Model 3. 

---

### * [Multi technique](Multi_technique.md )

---

### * [Multi pass](Multi_pass.md)

---

### Multi technique, Multi pass
With the use of Multi technique, you can also program multiple passes within this technique.  

---

### Transfer parameters from the Technique to the Pixel Shader:


For different shader passes, you can also give the Pixel Shader different parameters.
Sampler name, and values (of variables, formulas or directly).
For example, the Sampler1 und the value 0.5:  
`ps_main(Sampler1, 0.5)`

``` Code
//--------------------------------------------------------------//
// Techniques
//--------------------------------------------------------------//

technique MyEffect
{
   pass P_1
   {
      PixelShader = compile PROFILE ps_main(Sampler1, 0.5);
   }
}
```
[The Shader section shows how to assign these parameters to the sampler and the variable.](../Shaders/README.md#take-parameters-from-the-technique).


