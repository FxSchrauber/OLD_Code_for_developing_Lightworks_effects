
# Functions

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

You can call such functions in shaders.
In effect code, these shaders must be below this function code.

---

* [CG_standard_library (Intrinsic Functions, already implemented)](CG_standard_library/README.md)

---

User-created functions in [other code collections of this repository](../README.md).

---


*jwrl wrote:*
>I also prefix any functions that I use with fn_, and shaders with ps_ so that it's immediately clear what's going on.  
>If I decide to create a variant of fmod() that always returns a positive result there will be no confusion if my function  
>is called fn_fmod(). That's actually a dumb example, but I suspect that you will get what I mean.
>  
>On the subject of functions, it will always be more efficient if you can manage to use as few as possible.
