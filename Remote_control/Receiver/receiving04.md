# receiving04
Version with return values in the **special range from 0 to 1** (in most cases, however, -1 to +1 are required).

This code fixes the problem of older receive codes which channels 100, 200, 300 etc. could not receive.

**Function call:** `fn_receiving04 (Ch)`  

### Purpose:  
Receive values from another effect or pixel shader. (For example, the value of a variable)  
Transmission path: As texture, coded in the RGBA values of a rectangular point.  
The code selects the center of that point in the texture and decodes the RG values.
The position and size of this point is defined in the [channel definition folder](../Channel_definitions/Channel_assignment.md) of this developer repository.

#### Return value:
   - *Type:* **scalar**
   - *Value range*: **0.0 to 1.0**
   - *Precision:* [~ 10 to 32 bit, details see below](#precision)

---

### Requirements

#### Required sampler and texture:
   - *Sampler:* `RcSampler`
   - *Separate texture for this sampler:*  Remote control input (see Channel definitions folder)
   - [Click here to see an optimized sampler code](#example-of-a-remote-control-optimized-texture-and-sampler-code)

#### Required function code:
```Code
float fn_receiving04 (float Ch)
{
   float  ch    = floor(Ch) - 1.0;
   float  posY  = floor(ch/100.0) / 50.0;
   float2 pos   = float2 ( frac(ch / 100.0) + 0.005  ,  posY + 0.01 );
  
   float2 sample = tex2D (RcSampler, pos).rg;
   return sample.r + (sample.g / 255.0);
}
```
* `ch` is the channel whose remote control signal is to be received.  
     Any fractional parts that could possibly be caused by an imprecisely set slider will be removed.  
     ` -1.0` is part of the problem solution to position Canal 100 and many of them correctly.
* `posY` is the vertical position (measured from the top) of the top edge of the rectangular color signal.  
* `pos` is the center of the rectangular color signal of the channel to be received.  
        The horizontal channel centering has been changed from `-0.005` to `+ 0.005` (compared to older codes) 
        because the internal channel numbering `ch` has been changed by `-1`.
* `sample` The receiving RG color signal.  
* `return sample.r + (sample.g / 255.0)` Calculate return value:
   *  `sample.r` Red = Bit 1 to bit 8 in case of 8 bit GPU precision setting  
   *  `+ (sample.g / 255.0)` Green = The intermediate values bit 9 to bit 16 in case of 8 bit GPU precision setting  


---

#### Parameter Description `Ch`:
  - Receiving Channel (see Channel definitions folder)
  - Ignores fractional part
  - *Type*: **scalar** `float`  
  
---
  
  
#### Example of a remote control optimized texture and sampler code:

```` Code
texture RC;

sampler RcSampler = sampler_state
{
   Texture = <RC>;
   AddressU = Border;
   AddressU = Border;
   MinFilter = Point;
   MagFilter = Point;
   MipFilter = Point;
};
````
*Reason for using `Border`:* If a channel position is set outside the texture (e.g., channel 0), a black border turns off the remote control (Return value = 0.0).

*Reason for using `Point`:*  Actually unnecessary, but should unexpected texture shifts occur, which is still within the position defined for that channel, 
                             then this will prevent unwanted interpolation.

  
---
  
  
#### Precision:

This code is designed to convert the low precision of an 8-bit red-green pixel value to a 16-bit precision scalar value.  
Setting a different GPU precision in the Lightworks project settings also affects the return value of this code:  
  
| GPU precision          | Precision of the return value                                   |
| :--------------------: | :------------------------------------------------------------------------------------------------ |
|8-bit                   |        16-bit                                                                                     |
|16-bit                  |        24-bit                                                                                     |
|16-bit Floating Point   |     >= 10-bit!  No proportional accuracy dependency on value, but strongly fluctuating cyclically.|
|32-bit Floating Point   |      ~ 32-bit                                                                                     |

The return value is decoded from the red and green channels.
The red channel contains the coarse values, and the green channel contains the intermediate values (example: 8 bits + 8 bits = 16 bits).  

The reasons for the mostly less accurate return values when setting "16-bit Floating Point"
are due to the fact that the precision of the RGBA values decreases with increasing values. 
With very low RGBA values the precision can be very high, but at the upper end it is only about 11 bits.
Because the calculation basis for the Markos changes under these fluctuating conditions, the precision of the return value is not increased.  

With GPU settings of "16-bit" or "16-bit Floating Point", the calculation basis is indeed changed, but makes in these cases, less or not noticeable.  

Option (other code):  
With 16-bit Floating Point or 32-bit Floating Point precision set, the value could also be taken directly from the alpha channel  
because the remote control effects on that channel send the value without conversion.  
This also applies to other GPU precision settings if the return value needs to be less accurate.  
This could slightly reduce the GPU load.
