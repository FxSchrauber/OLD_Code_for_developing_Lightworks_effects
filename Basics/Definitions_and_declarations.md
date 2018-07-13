# Definitions and declarations


*jwrl wrote:*

>[...] here's an example of the definitions block that I often start with.  
``` Code
//--------------------------------------------------------------//
// Definitions and declarations
//--------------------------------------------------------------//

#define BLACK   float2(0.0,1.0).xxxy

#define HALF_PI 1.5707963
#define PI      3.1415927
#define TWO_PI  6.2831853

float _OutputWidth;
float _OutputAspectRatio;

#define Output_Height (_OutputWidth/_OutputAspectRatio)
```
> I then delete what I don't need.  

Definitions, which are already available by default for testing the operating system used,  
can be found under ["Special auto-synced parameters and definitions"](Variables_etc/Auto_synced/README.md)  

More definitions can be found in [other code collections of this repository](../README.md) (for example, macros).
