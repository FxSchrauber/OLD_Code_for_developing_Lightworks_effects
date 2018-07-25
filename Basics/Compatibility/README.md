# Cross-platform compatibility

1. In the "Techniques" section, use the default code: "... compile **`PROFILE`** ..."  
   Starting with Lightworks 14.5, the operating system can be determined at compile time.  This can allow for explicit shader profile declaration in Windows, amongst other things.  It offers [new possibilities](../Techniques/README.md). 

---

2. *Great White wrote:*   
   >For reference, the shader compiler on Linux :   
      > - Does not like variables that are declared as 'const'  
      > - Prefers 'fmod' instead of '%'  
 
   *jwrl wrote:*  
      >The reference to Linux in Great White's answer can also be taken to include OS-X.  
   
---

3. Application of variables into [Cg standard functions](../Functions/CG_standard_library/README.md):  
  Example: lerp (a, b, w);
  Quote [Nvidia's Cg reference manual, page 729:](https://www.google.com.au/url?sa=t&rct=j&q=&esrc=s&source=web&cd=3&cad=rja&uact=8&ved=0ahUKEwj5qpif6rHTAhXLF5QKHQ6MCeAQFggwMAI&url=http%3A%2F%2Fdeveloper.download.nvidia.com%2Fcg%2FCg_3.1%2FCg-3.1_April2012_ReferenceManual.pdf&usg=AFQjCNHI5gaVpuvJH6ZO8bnX7BxJGKXr0A)  
   > a and b are either both scalars or both vectors of the same depth.  If a is a float2 then b must also be a float2, and both must be explicitly declared.  If you do not, there will be cross-platform problems because Windows and Mac/Linux compilers handle implicit variable conversion in different ways.
   
   For an example and the solution, see [lwks.com post #146013](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=45&Itemid=81#146013).  

---

4. Avoid nested and incomplete comment delimiters.  
   The following erroneous example contain 3 opening comment delimiters, but only 2 closing comment delimiters:  
   ` /* Comment 1    /* Comment 2 */     /* Comment 3  */`  
   
   In Windows that will compile but only because of a compiler bug.  It will not compile at all on Linux and Mac systems.  The forms:  
   ` /* Comment 1  */    /* Comment 2 */     /* Comment 3`  
   ` /* Comment 1  */    /* Comment 2 */     Comment 3 */`  
   
   will fail on all compilers.
   
   ---
   
5. Linux and Mac: Only one sampler can be created per texture.  On Windows while it's possible to have as many as you like up to the capacity of the profile used, it's extremely bad practice and will lead to compatibility problems.

---

6. Sampler settings:  
   The sampler setting `Clamp` should not be used, because this behaves differently on Linux / Mac systems to the way that it does on Windows systems.      Starting with Lightworks 14.5, we can instead use `ClampToEdge` for all operating systems, but not on older versions of Lightworks.  
   
   **** I am unsure about the above and did not write it: if the Windows compiler is presented with an addressing mode that it doesn't understand it will ignore it.  This may in fact be what's happening when ClampToEdge is used on Windows.  The example that Great White gave when explaining this showed the ClampToEdge switch being explicitly redefined as Clamp for Windows systems.  It seems likely that this is still the case.  Rigorous testing will be necessary before something like that can be stated as a design principle - jwrl.
   
---

7. You cannot assign a value to a sampler inside a function or shader in Linux/Mac code.  
   For details, see  [lwks.com post # 152430](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=75&Itemid=81#152430).
