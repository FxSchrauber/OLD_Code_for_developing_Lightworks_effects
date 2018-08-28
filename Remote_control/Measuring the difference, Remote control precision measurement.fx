//--------------------------------------------------------------/
// Test-Effect
// Remote control precision measurement
//
// The effect internally generates a test ramp from 0 to 1 (or optionally more).
// This value is encoded in red and green values and rendered.
// The Green color values contain intermediate levels, which may be lost when rendering the red color values (depending on the GPU precision).

// In the shader "ps_decode", the same test ramp is generated internally as a reference.
// The rendered RG color values are decoded back to a scalar value. This value is compared with the reference ramp.
// Deviations are displayed graphically on a black background.
// Starting from an invisible horizontal zero line in the middle of the frame, 
// positive deviations are displayed in white (upward) and negative deviations are displayed in red (downward).

// Scaling of the difference display:
// By default ("Zoom, D1" = 10 000 and "Zoom D2" = 1), and a difference display in size of the entire frame height, would be a deviation of the values of 1E-4.
// "Zoom D1" affects the vertical display of the difference.
// "Zoom D2" zooms vertically and horizontally, allowing us to detect intermediate values and the form of deviation. 
// Because testing is done only by cutting the ramp, the position on the ramp should also be changed to test the entire ramp.
// However, this change in position should also be made independent of the zoom level in order to make more measurements of intermediate values on the ramp.
// The number of measurements on the ramp depends on the set project / video / output format. Therefore, the setting UHD is recommended.
// With the position's fine-tuning sliders, you can skim across the ramp to make measurements of closely spaced points on the ramp.

// If you want to test the behavior at values greater than 1, then in the effect settings disable "Clamp the test ramp" ..., 
// and change the position slider accordingly. 
// Depending on the GPU precision setting, completely different overdrive characteristics were noted.


//--------------------------------------------------------------//
int _LwksEffectInfo
<
   string EffectGroup = "GenericPixelShader";
   string Description = "Measuring the difference, Remote control precision measurement";
   string Category    = "User";
   string SubCategory = "Tools for developers";
   string Notes       = "Test-Effect";
> = 0;




//--------------------------------------------------------------//
// Inputs         Samplers
//--------------------------------------------------------------//


texture Input;          // This texture is not used, but stabilizes the display of the graphic.

texture render_test : RenderColorTarget;
sampler renderSample = sampler_state
{
   Texture = <render_test>;
};



//--------------------------------------------------------------//
// Parameters
//--------------------------------------------------------------//



bool limitingRamp
<
   string Description = "Clamps the test ramp between 0 to 1.";
> = true; 



float ZoomDiffY
<
   string Group = "Zoom, 1D (Magnified representation of the difference)";
   string Description = "Zoom difference";
   float MinVal = 1.0;
   float MaxVal = 1.0E6;
> = 1.0E4;




float Zoom
<
   string Group = "Zoom, 2D (> 1: only one section of the ramp is tested):";
   string Description = "1 to 10000";
   float MinVal = 1.0;
   float MaxVal = 10000.0;
> = 1.0; 




float ZoomPos
<
   string Group = "Test with different zoom positions to make more values visible:";
   string Description = "Position";
   float MinVal = 0.0;
   float MaxVal = 1.0;
> = 0.0;

float fineP001
<
   string Group = "Test with different zoom positions to make more values visible:";
   string Description = "Fine x 0.01";
   float MinVal = -1.0;
   float MaxVal = 1.0;
> = 0.0;

float fineP00001
<
   string Group = "Test with different zoom positions to make more values visible:";
   string Description = "Fine x 0.0001";
   float MinVal = -1.0;
   float MaxVal = 1.0;
> = 0.0;







//--------------------------------------------------------------//
// Definitions and declarations
//--------------------------------------------------------------//


#define COLORwhite       float4 (1.0,1.0,1.0,1.0)
#define COLORred         float4 (0.6, 0.0, 0.0, 1.0)
#define ZOOMPOS      ( ZoomPos  +  fineP001 * 0.01  +  fineP00001 * 0.00001 )


#define ZEROline 0.5


//-----------------------------------------------------------------------------------------//
//               *****  Pixel Shader  *****
//-----------------------------------------------------------------------------------------//




float4 ps_render (float2 xy : TEXCOORD1) : COLOR
{ 
   float ramp = xy.x / Zoom + ZOOMPOS;					// Variable to be rendered as color.
   if (limitingRamp) ramp = clamp (ramp, 0.0, 1.0);

						
   float green = frac(ramp * 255.0);
   float red = ramp - green / 255.0;

   return float4 (red , green ,0.0, 0.0);														
} 









float4 ps_decode (float2 xy : TEXCOORD1) : COLOR
{ 
 

   float reference = xy.x / Zoom  +  ZOOMPOS;                   // Ramp values for comparison with rendered values
   if (limitingRamp) reference = clamp( reference , 0.0, 1.0);


   // ... Decoding
   float4 sample = tex2D(renderSample,xy);
   
   //float decoded =  sample.r + (sample.g / 255.0);       //Simple code (inaccurate with 16-bit floating point (GPU precision setting))
     float decoded = (round (sample.r * 255.0) / 255.0)  +  (sample.g / 255.0);



  // ... Analysis (Displays the difference to the variable before rendering)

  float difference = (decoded - reference)  ;	

   if (   (difference * Zoom * ZoomDiffY)  >  ZEROline - xy.y  &&  xy.y <= ZEROline  )
      {
          return COLORwhite;                          // White in case of positive difference
      }


   if (   (difference * Zoom * ZoomDiffY)  <  ZEROline - xy.y  &&  xy.y >= ZEROline  )
      {
         return COLORred;                            // Red in case of positive difference
      }
	
   return 0.0;													
} 





//-----------------------------------------------------------------------------------------------//
// Technique
//-----------------------------------------------------------------------------------------------//



technique tech_main
{
   pass P_render
   <
      string Script = "RenderColorTarget0 = render_test;";
   >
   {
      PixelShader = compile PROFILE ps_render();
   }


   pass P_decode
   {
      PixelShader = compile PROFILE ps_decode();
   }
}

