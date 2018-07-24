# receiving

**Old version**, which is still being used in effects. For new effects please use more up-to-date code.  

---

**Function call:** `fn_receiving (Ch)`  

*or* **Macro call:** `RECEIVING (Ch)`
  ([Macro code](#macro-code) can be found at the bottom of this page)

### Purpose:  
Receive values from another effect or pixel shader. (For example, the value of a variable)  
Transmission path: As texture, coded in the RGBA values of a rectangular point.  
The code selects the center of that point in the texture and decodes the RGB values.
The position and size of this point is defined in the [channel definition folder](../Channel_definitions/Channel_assignment.md) of this developer repository.

#### Return value:
   - *Type:* **scalar**
   - *Value range*: -1.0 to +1.0
   - *Precision:* [~ 10 to 32 bit, details see below](#precision)

### Limitations:
This code is unsigned for the special channels 100 and a multiple of it (for example, channel 100, 200, etc.).
The code below will position the sampler out of texture at such channel settings.

---
### Requirements

#### Required sampler and texture:
   - *Sampler:* `RcSampler`
   - *Separate texture for this sampler:*  Remote control input (see Channel definitions folder)
   - [Click here to see an optimized sampler code.](#example-of-a-remote-control-optimized-texture-and-sampler-code)

#### Required function code:
```Code
float fn_receiving (float Ch)
{
   float  ch    = floor(Ch);
   float  posY  = floor(ch/100.0) / 50.0;
   float2 pos   = float2 ( frac(ch / 100.0) - 0.005  ,  posY + 0.01 );
  
   float4 sample   = tex2D (RcSampler, pos );

   float status = sample.b;

   return ( sample.r
             + (sample.g / 255.0)
          ) * 2.0 - step( 0.001 , status);
}
```
* `ch` is the channel whose remote control signal is to be received.  
     Any fractional parts that could possibly be caused by an imprecisely set slider will be removed.  
* `posY` is the vertical position (measured from the top) of the top edge of the rectangular color signal.  
* `pos` is the center of the rectangular color signal of the channel to be received.  
* `sample` The receiving RGBA color signal.  
* `status` [The status of the receiving channel.](../Channel_definitions/Channel_assignment.md#blue-color-channel-status-messages)
* Calculate return value:
   *  `sample.r` Red = Bit 1 to bit 8 in case of 8 bit GPU precision setting  
   *  `+ (sample.g / 255.0)` Green = The intermediate values bit 9 to bit 16 in case of 8 bit GPU precision setting
   *  ` * 2.0 - step( 0.001 , status);`
      Adjustment of the numeral system from  ( 0 ... 1) to (-1 ... +1)  
      If Status Channel >= 0.001 then step = 1 (this line then performs the adjustment `*2 -1`)  
      If the Status = 0.0 (no remote control) then this line then performs the adjustment `*2 -0`  
      This prevents the receive value 0 in -1 from being changed.  


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
  

---
---
---

## Macro code:
  
#### Required macros:
   - *Main macro:* `RECEIVING`
   - *Sub macros:*
      - `STATUS_CH_IN` (is called by main macro `RECEIVING`)
      - `POSCHANNEL`   (is called by main macro `RECEIVING` and sub madro `STATUS_CH_IN`)
      - `POSyCHANNEL`  (is called by sub macro `STATUS_CH_IN`) 

Within the macro code, no variables were used. Instead, intermediate calculations were performed in sub-makos.  
The order of the macros is not important (tested with Windows) because the preprocessor automatically assembles these 
codes correctly in the calling shader (of course, the macro codes must always be defined above the macro call).


#### All required macro codes:

```` Code
#define RECEIVING(Ch)    (    (   tex2D(RcSampler, POSCHANNEL(floor(Ch))).r \
                                + ((tex2D(RcSampler, POSCHANNEL(floor(Ch))).g) / 255.0) \
                              ) * 2.0 - step( 0.001 , STATUS_CH_IN(Ch))  )
                             
#define STATUS_CH_IN(Ch)     ((tex2D(RcSampler, POSCHANNEL(floor(Ch)))).b)
            
   #define POSCHANNEL(ch)       float2 ( frac(ch / 100.0) - 0.005  ,  POSyCHANNEL(ch) + 0.01 )
      #define POSyCHANNEL(ch)        ( (floor( ch/100.0) )/ 50.0 )
````         
  
### Description of the macro codes:


#### Sub macro for determining the position of the receive channel within the remote control texture:
```` Code
#define POSCHANNEL(ch)    float2 ( frac(ch / 100.0) - 0.005  ,  POSyCHANNEL(ch) + 0.01 )
```` 
 
 1. -0.005 and  +0.01 ar the center of the respective position and dimensions.  
 2.  This code should be changed in the future, because it does not allow access  
     to the currently blocked special channels 100, 200, 300 ... 1000, 1100 etc.  
 3.  The y position is determined in the separate sub macro.  
 4.  `ch` is the receiving channel    
   
---
  
  
#### Sub macro for determining the y-position of the receive channel within the remote control texture:
```` Code
#define POSyCHANNEL(ch)  ( (floor( ch/100.0) )/ 50.0 )
```` 
  
  
---
  
  
#### Sub macro for determining the status of the receive channel:
```` Code
#define STATUS_CH_IN(Ch)     ((tex2D(RcSampler, POSCHANNEL(floor(Ch)))).b)
````
  1. Definitions of status messages as values on the blue channel, see: [Channel_assignment]
  2. The value of Channel `Ch` Input is only passed to sub macros 



---


#### The main macro:
```` Code
#define RECEIVING(Ch)(                                                \
                        (   tex2D(RcSampler, POSCHANNEL(floor(Ch))).r \
                          + ((tex2D(RcSampler, POSCHANNEL(floor(Ch))).g) / 255.0) \
                        ) * 2.0 - step( 0.001 , STATUS_CH_IN(Ch)) \
                     )
````

Detailed description of the components of the main macros:
```` Code
tex2D(RcSampler, POSCHANNEL(floor(Ch))).r
````
  1. Receiving  Red = bit 1 to bit 8 in case of 8 bit GPU precision setting  
  2. The value of  "Ch" (receiving channel) is only passed to sub macros  


```` Code
+ ((tex2D(RcSampler, POSCHANNEL(floor(Ch))).g) / 255.0)
````
 1. Receiving Green = The intermediate values bit 9 to bit 16 in case of 8 bit GPU precision setting  
 2. The value of  "Ch" (receiving channel) is only passed to sub macros  

```` Code
* 2.0 - step( 0.001 , STATUS_CH_IN(Ch))
````
 1. Adjustment of the numeral system from  ( 0 ... 1) to (-1 ... +1)  
      If Status Channel >= 0.001 then step = 1 (this line then performs the adjustment `*2 -1`)  
      If the Status = 0.0 (no remote control) then this line then performs the adjustment `*2 -0`  
      This prevents the receive value 0 in -1 from being changed.  
     
 2. The value of  "Ch" (receiving channel) is only passed to sub macros  
