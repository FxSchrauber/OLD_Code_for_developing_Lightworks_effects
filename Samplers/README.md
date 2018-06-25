# Samplers

## Update: There are new insights into which settings may be used for Windows, and which for Linux / Mac.  
 Details are discussed [lwks.com starting on page 12.](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=165&Itemid=81#ftop)
 and [lwks.com starting on page 20.](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=285&Itemid=81#ftop)
 
---


## Old documentation:

#### Cross-platform compatibility:  
 Linux and Mac: Only one Sampler can be created per texture.  
 
 
### Sampler settings
  In case the scaling is changed or the texture position is shifted  
 (sampler position is different than the original texture coordinates):  
   Please always set AddressU, AddressV, MinFilter, MagFilter and the MipFilter for each sampler. Otherwise, 
   undefined states can lead to unexpected results.
   
  - [**A code example** to create samplers for the three previously programmed Inputs](example01.md)
  
  
  
  
  
  
  
  
    
``` Code
 ```
