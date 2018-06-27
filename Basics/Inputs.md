An example of a test effect:
``` Code
//--------------------------------------------------------------//
// Inputs
//--------------------------------------------------------------//

texture In1;
texture In2;

texture OutputFromPassOne : RenderColorTarget;  
```

The result for the effect "Sampler test2" then looks as follows:  
![](images/Sampler_Test_2017-04-26.png)

"texture OutputFromPassOne" ... is not visible in the routing because the video signal (texture) comes from a pixel shader within it effect.
 This is set by ": RenderColorTarget".
 From which pixel shader this internal texture comes, we programmed in the "Techniques" section (more on this later in another posts "Techniques").



### Pixel color:
  - In order for the pixel shader to read the pixel colors of the three textures, we have to create the corresponding samplers (see the "Samplers" section).


### Texture coordinates:
  - The effect inputs also provide texture coordinates needed by the pixel shader to determine the position of the pixels:
    - **TEXCOORD1** 
    - **TEXCOORD2**
    - usw.

 Note: Only textures that are visible as input in video routing are considered. Internal textures that are rendered only within the effect and sent to a sampler can not be used as a source for texture coordinates. Example:

``` Code
//--------------------------------------------------------------//
// Inputs
//--------------------------------------------------------------//

texture In1;                                    // Imput1 (TEXCOORD1)
texture OutputFromPassOne : RenderColorTarget;
texture In2;                                    // Imput2 (TEXCOORD2)
```
[(see the "Samplers" section)](README.md#details).



## New in Lightworks 14.5:

Great White wrote:
> I've added some experimental support in the latest beta which allows you to refer to image files directly  
> from within Lightworks pixels-shader effect files. For example, you can now write something like :

``` Code
texture _Grain < string Resource = "FilmGrain.png"; >;
```

Great White wrote:
> Which will cause the '_Grain' texture to be initialised with image-data in FilmGrain.png. 
>
> The texture variable name should start with a leading underscore to prevent it from being identified as an effect input,  
> and the specified image should be located in the same folder as the .fx file ...


More details and tests see on / from [lwks.com page 15 starting with Post # 170010.](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=210&Itemid=81#170010)

