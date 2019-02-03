# Version14_5_check

**This code checks whether the Lightworks version used supports all the auto-synced parameters and definitions 
supported by version 14.5.  
If the incompatibility is detected, then a meaningful compiler warning is generated.**

---
  
### Code:

```` Code
// Code ID: Version14_5_check 
#ifndef _LENGTH
   Bad_LW_version
#endif
````

**Description:**  

- `#ifndef _LENGTH` Only available in version 14.5 and up  
  This also means that the version used also supports all other variables and definitions added with version 14.5. 
  An overview of what is supported from which version can be found in the 
  [Basics](../Basics/Variables_etc/Auto_synced/README.md).
    
- `Bad_LW_version`  Forces a compiler error if the Lightworks version is bad.  
  Error message `error X3000: unrecognised identifier 'Bad_LW_version'` 


--- 


### Hint:
jwrl wrote:
> By the way, never include that code block until you have fully developed your effect. 
> It can affect the compiler's behaviour in odd ways. 
> I spent a morning a while ago trying to work out why an additional parameter in an effect that I was developing appeared to do nothing. 
> Commenting out that block and restarting Lightworks fixed the problem. Reinstating the code caused problems during development again.  
>   
> Of course, once the effect is fully developed it works as planned with that code in place. 
