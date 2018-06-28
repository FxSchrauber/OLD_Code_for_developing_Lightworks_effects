# Samplers

#### Compatibility:  
   - [Info: lwks.com starting on page 12.](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=165&Itemid=81#ftop)  
   - [Info: lwks.com starting on page 20.](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=285&Itemid=81#ftop)
   - Linux and Mac: Only one Sampler can be created per texture.  
 
 
### Sampler settings
  - Examples:
     - Create a sampler called "BorderSample"  that uses the texture of input "In1"
       ``` Code
       sampler BorderSampler = sampler_state
       {
          Texture = <In1>;
          AddressU = Border;
          AddressV = Border;
          MinFilter = Linear;
          MagFilter = Linear;
          MipFilter = Linear;
       };
       ```
     - [Another example with several samplers](example_code.md)
  - In case the scaling is changed or the texture position is shifted 
    (sampler position is different than the original texture coordinates):  
    Please always set AddressU, AddressV, and Filter for each sampler.
    Otherwise, undefined states can lead to unexpected results.
  - If your effect moves the original position of the pixels (eg zooming), then it can happen:
     - That the calculation results in pixel positions outside the source textures  
       (outside the normal range from 0 to 1).  
       (Behavior can be set with "AddressU" and "AddressV")  
     - That pixel positions have been calculated that are not at the center of a pixel (Wndows).
       (Behavior adjustable with filter settings)
     - There are several ways the sampler should proceed in these cases (Windows).
       ![](images/Sampler-mix.png)
 - Examples of different **Address** settings  
   The following examples were zoomed out.
   Note that zooming is not done with the sampler settings, but is programmed in the program part "Shaders".
    - [**Border**](Border.md)
    - [**Mirror**](Mirror.md)
    - [**ClampToEdge**](Clamp.md)
    - [Horizontal **Border** and vertical **ClampToEdge**](Border_Clamp.md)
    - [**Wrap**](Wrap.md)
 - Filer
    - **`MinFilter = Linear`**  (Zoom out)  
      **`MagFilter = Linear`**  (Zoom in)  
      This causes the sampler to mix adjacent pixels when looking for a position between the centers of those pixels.  
   - **`MinFilter = Point`**  (Zoom out)  
     **`MagFilter = Point`**  (Zoom in)  
     This setting prevents pixel interpolation.  
   -  MipFilter (It is unclear whether this filter has any function in Lightworks effects)?
   
      
