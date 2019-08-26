# Definitions and declarations


Example:  
``` Code
//--------------------------------------------------------------//
// Definitions and declarations
//--------------------------------------------------------------//

#define BLACK   float4(0.0.xxx, 1.0.y)

#define HALF_PI 1.5707963
#define PI      3.1415927
#define TWO_PI  6.2831853

float _OutputWidth;
float _OutputAspectRatio;

#define OUTPUT_HEIGHT (_OutputWidth / _OutputAspectRatio)
```  

Definitions, which are already available by default for testing the operating system used,  
can be found under ["Special auto-synced parameters and definitions"](Variables_etc/Auto_synced/README.md)  

More definitions can be found in [other code collections of this repository](../README.md) (for example, macros).
