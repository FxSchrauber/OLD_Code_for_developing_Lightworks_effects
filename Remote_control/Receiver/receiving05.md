# receiving05

This code is similar to "receiving03", but significantly increases the transmission prescription with the GPU precision "16-bit Floating point" set.

**Function call:** `fn_receiving05 (Ch)`  

### Purpose:  
Receive values from another effect or pixel shader. (For example, the value of a variable)  
Transmission path: As texture, coded in the RGBA values of a rectangular point.  
The code selects the center of that point in the texture and decodes the RGB values.
The position and size of this point is defined in the [channel definition folder](../Channel_definitions/Channel_assignment.md) of this developer repository.

#### Return value:
   - *Type:* **scalar**
   - *Value range*: -1.0 to +1.0
     In the case of floating-point GPU precision adjustment, experimentally values of> +1 may be possible, but this will reduce precision.
   - *Precision:* [see below](#precision)

---

### Requirements

#### Required sampler and texture:
   - *Sampler:* `RcSampler`
   - *Separate texture for this sampler:*  Remote control input (see Channel definitions folder)
   - [Click here to see an optimized sampler code](#example-of-a-remote-control-optimized-texture-and-sampler-code)

#### Required function code:
```Code
float fn_receiving05 (float Ch)
{
   float  ch    = floor(Ch) - 1.0;
   float  posY  = floor(ch/100.0) / 50.0;
   float2 pos   = float2 ( frac(ch / 100.0) + 0.005  ,  posY + 0.01 );
  
   float4 sample = tex2D (RcSampler, pos );
   float status = sample.b;
   float ret = round (sample.r * 255.0) / 255.0
             + sample.g / 255.0;
   ret = status > 0.001 ? ret * 2.0 -1.0 : 0.0;

   return ret;
}
```
* `ch` is the channel whose remote control signal is to be received.  
     Any fractional parts that could possibly be caused by an imprecisely set slider will be removed.  
     ` -1.0` is part of the problem solution to position Canal 100 and many of them correctly.
* `posY` is the vertical position (measured from the top) of the top edge of the rectangular color signal.  
* `pos` is the center of the rectangular color signal of the channel to be received.  
        The horizontal channel centering has been changed from `-0.005` to `+ 0.005` (compared to older codes) 
        because the internal channel numbering `ch` has been changed by `-1`.
* `sample` The receiving RGBA color signal.  
* `status` [The status of the receiving channel.](../Channel_definitions/Channel_assignment.md#blue-color-channel-status-messages)
* `ret` Calculate return value:
   * `round (sample.r * 255.0) / 255.0` Red = Bit 1 to bit 8.
      The code removes intermediate values, which are transmitted with GPU-Päzisionen above 8-bit. 
      With "16-bit floating point", these intermediate values would considerably reduce the precision of the decoded value 
      because subsequently the precise intermediate values coded in the green color channel are added.
   *  `+ sample.g / 255.0` Green = The intermediate values bit 9 to bit 16 in case of 8 bit GPU precision setting
* `ret = status > 0.001 ? ret * 2.0 -1.0 : 0.0;`  
   If Status Channel > 0.001, then the number system is rescaled from (0 ... 1) to (-1 ... +1).  
   Otherwise, ret = 0. This ensures that the return value is 0 when the remote control channel is offline.   


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

*Reason for using `Point`:*  Actually unnecessary, but should unexpected texture shifts occur, which is still within the position defined for that channel, then this will prevent unwanted interpolation.

  
---
  
  
#### Precision:
Tested with LWKS 14.5, Windows, Intel HD Graphics 4600

| GPU precision          | Maximum deviation within a return value range from -1 to +1  |
| :--------------------: | :----------------------------------------------------------- |
|8-bit                   |    +16E-6  (+0.000016)       and -16E-6   (-0.000016)        |
|16-bit                  |    +25E-8  (+0.00000025)     and  -7E-8   (-0.00000007)      |
|16-bit Floating Point   |    +13E-8  (+0.00000013)     and  -4E-6   (-0.000004)        |
|32-bit Floating Point   |    +13E-8  (+0.00000013)     no negative difference measured |

The return value is decoded from the red and green channels.
The red channel the coarsely graded 8-bit values, and the green channel contains the intermediate values (example: 8 bits + 8 bits = 16 bits).  

Option (other code):  
With 32-bit Floating Point precision set (if supported), the value could also be taken directly from the alpha channel  
because the remote control effects on that channel send the value without conversion. 
In this case, the received value would be absolutely identical to the original value.
The alpha channel can also be used by others GPU precision settings if the return value needs to be less accurate.  
This could reduce the GPU load.
