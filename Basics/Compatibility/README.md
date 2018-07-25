# Cross-platform compatibility

1. In the "[Techniques](../Techniques/README.md)" section, use the default code: "... compile PROFILE ..."

 Starting with Lightworks 14.5 the operating system can be identified at compile time. 
 This allows the profile to be set to explicitly suit the operating system used. 

---

2. *Great White wrote:*   
   >For reference, the shader compiler on Linux :   
      > - Does not like variables that are declared as 'const'  
      > - Prefers 'fmod' instead of '%'  
 
   *jwrl wrote:*  
      >The reference to Linux in Great White's answer can also be taken to include OS-X.  
   
---

3. Application of variables into [Cg standard functions](../Functions/Cg_standard_library/README.md):  
  Example: lerp (a, b, w);
  Quote [Nvidia's Cg reference manual, page 729:](https://www.google.com.au/url?sa=t&rct=j&q=&esrc=s&source=web&cd=3&cad=rja&uact=8&ved=0ahUKEwj5qpif6rHTAhXLF5QKHQ6MCeAQFggwMAI&url=http%3A%2F%2Fdeveloper.download.nvidia.com%2Fcg%2FCg_3.1%2FCg-3.1_April2012_ReferenceManual.pdf&usg=AFQjCNHI5gaVpuvJH6ZO8bnX7BxJGKXr0A)  
   > a and b are either both scalars or both vectors of the same length.  

   If you do not there will be cross-platform problems. 
   The way that the Windows compiler and the Mac/Linux compilers handle this type of implicit variable 
   conversion differs and you can get unpredictable results if you rely on it.  
   For an example and the solution, see [lwks.com post #146013](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=45&Itemid=81#146013).  

---

4. Avoid nested and incomplete comment delimiters.  
   The following erroneous example contains 3 opening comment delimiters, but only 2 closing comment delimiters:  
   `/* Comment 1 /* Comment 2 */ /* Comment 3 */`  
   In Windows because of a compiler bug this may compile. It will not on Linux or Mac systems.  
   However the following versions will fail on all systems.  
   `/* Comment 1 */ /* Comment 2 */ /* Comment 3`  
   `/* Comment 1 */ /* Comment 2 */ Comment 3 */`  
   
---
   
5. Only one sampler should be created per texture.  
  While it's possible to overload sampler declarations in Windows it isn't on the other two platforms supported by Lightworks, 
  and doing so will break your effect in them.  
  
---

6. Sampler settings:  
   The sampler addressing mode Clamp should not be used because this behaves differently on Linux/Mac systems 
   to the way that it does on Windows systems. For Linux/Mac you should use ClampToEdge instead, 
   and starting with Lightworks 14.5 the Windows compiler has been modified so that you can use it there too. 
   This makes that addressing mode fully cross-platform on 14.5 and up.  
   
   Obviously this will not work on versions of Lightworks prior to 14.5. 
   For those cases separate Windows versions using Clamp addressing instead of ClampToEdge must be created for the effect to compile.
   
---

7. You cannot assign a value to a sampler inside a function or shader in Linux/Mac code.  
   For details, see  [lwks.com post # 152430](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=75&Itemid=81#152430).
