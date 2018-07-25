
# Functions


#### [Cg_standard_library (Intrinsic Functions)](Cg_standard_library/README.md)  
   You can call these functions directly.

--- 
### More Functions

You can also program new functions.

A template that you can complete with your code to implement a new feature for your effect:
``` Code
//--------------------------------------------------------------//
// Functions
//--------------------------------------------------------------//

float2 fn_some_func (...)
{

...

}
```

You can call such functions in [shaders](../Shaders/README.md ).  
In effect code, these shaders must be below this function code.  

Keep in mind that each shader can handle only a limited amount of code complexity 
(depending on the [shader model](../Techniques/README.md ) used in Windows). 
The code of functions increases the complexity of the shaders in which the functions are called. 
The use of functions can, from the perspective of the shader, increase the complexity more than if the code had been 
inserted directly in the shader.  
In the event that the complexity of your shader comes up against the limits of the shader model used, 
this could prevent compilation or increase the GPU load. In these cases, it might be useful to insert the code contained 
in the function directly into the shader. In many other cases, you probably will not notice any differences at all?


---

Codes for creating functions can be found in [specialized topics of this library.](../../README.md).

---

#### Prefix `fn_`:
*jwrl wrote:*
>I also prefix any functions that I use with fn_, and shaders with ps_ so that it's immediately clear what's going on.  
>If I decide to create a variant of fmod() that always returns a positive result there will be no confusion if my function  
>is called fn_fmod(). That's actually a dumb example, but I suspect that you will get what I mean.
