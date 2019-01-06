# tanh ()

See **page 759** in the PDF document: [Nvidia's Cg reference manual](https://www.google.com.au/url?sa=t&rct=j&q=&esrc=s&source=web&cd=3&cad=rja&uact=8&ved=0ahUKEwj5qpif6rHTAhXLF5QKHQ6MCeAQFggwMAI&url=http%3A%2F%2Fdeveloper.download.nvidia.com%2Fcg%2FCg_3.1%2FCg-3.1_April2012_ReferenceManual.pdf&usg=AFQjCNHI5gaVpuvJH6ZO8bnX7BxJGKXr0A)

  - #### Mathematical basics: https://en.wikipedia.org/wiki/Hyperbolic_function#Tanh  
  
  - #### Example of return values of tanh when using a ramp from -2 to +2 for the parameter:  
   ![](image/tanh.png)

  - #### [Video](video/tanh.mp4?raw=true) of the tanh return characteristic with different linear parameter ramps.  
  - #### This code was used for the test:
     Function:
     ```` Code
     float fn_test (float ramp)
     {                
        ramp = (ramp * 2.0 - 1.0);    // Ramp -1 to + 1
        ramp *= TestValue;            // Range of the ramp ("TestValue" is the value of the slider in the video) 
        if (Mode == 0) return ramp;   // Values of the ramp, if this effect mode was selected.
        return tanh (ramp);           // Values of the tanh, if this effect mode was selected.
     }
     ````
     
     Function call in the shader:
     ```` Code
     fn_test (xy.x);     // Parameter xy.x corresponds to a ramp from 0 to 1
     ````
     
     
  ---
  
  ### Values, examples
  Calculated values. Actual return values may differ slightly (especially for parameter values of > +7 and <-7)
  
 | Parameter | Return value | Difference to saturation|
 |:---------:| ------------:| -----------------------:|
 |     -9    | -0.99999997  |         -3.05E-008      |
 |     -8    | -0.9999997   |         -2.25E-007      |
 |     -7    | -0.99999834  |         -1.66E-006      |
 |     -6    | -0.99998771  |         -1.23E-005      |
 |     -5    | -0.99990920  |         -9.08E-005      |
 |     -4    | -0.99932930  |         -6.71E-004      |
 |     -3    | -0.99505475  |         -4.95E-003      |
 |     -2    | -0.96402758  |         -3.60E-002      |
 |     -1    | -0.76159416  |         -2.38E-001      |
 |      0    |  0.00000000  |          1              |
 |     +1    |  0.76159416  |          2.38E-001      |
 |     +2    |  0.96402758  |          3.60E-002      |
 |     +3    |  0.99505475  |          4.95E-003      |
 |     +4    |  0.99932930  |          6.71E-004      |
 |     +5    |  0.99990920  |          9.08E-005      |
 |     +6    |  0.99998771  |          1.23E-005      |
 |     +7    |  0.99999834  |          1.66E-006      |
 |     +8    |  0.99999977  |          2.25E-007      |
 |     +9    |  0.99999997  |          3.05E-008      |
 
The calculation of the difference to saturation in this table:  
Negative parameter values: `-1 - Return value`  
Positive parameter values: `+1 - Return value`  

     
  ---
  ---
     
## Critical parameter values:

### Recommendation:
Make sure the parameter for tanh stays within the range of **-9 to +9**.  
One possibility is for example:
```` Code
#define TANH(value)   tanh (clamp ( value , - 9.0 , 9.0))
````
Once you have defined this, you can simply use `TANH ()` in the code instead of `tanh ()`.  
  

### Reason for this range:
When using parameter values from 0 to 8.4, the return value comes closer to the saturation value (1).  
A parameter value of 8.4 gave a return value of 0.999 999 9  
The same applies to negative values.  
For parameter values outside a range of **-9 to +9**,  
only differences due to mathematical inaccuracies were detected in the test.  
(tested with Windows, GPU:Intel HD Graphics 4600)  

In the **[Video](video/cirtic_values3.mp4?raw=true)** you can see the difference of the saturation value of 1, 
where the graphic is scaled a maximum difference of 1E-6 to detect the smallest inaccuracies.  
The parameter used is again a scalable ramp, as in the previous test.

     
If the parameter values are too high, mathematical inaccuracies can lead to unexpected return values.
Some sample videos (tested with Windows, GPU:Intel HD Graphics 4600):

   - In this example, if the parameter exceeds the value + -87, the return value unexpectedly jumps to 0:
   **[Video](video/cirtic_values1.mp4?raw=true)**  
     
   - With other code, the behavior can be completely different.  
     In this example, the ramp was not generated with the texture coordinates xy.x,  
     but with the Auto-synced parameter `_Progress`.  
          Function call in the shader:
     ```` Code
     fn_test (_Progress);     // Relative effect position, Range 0 to 1
     ````
     From this, we created a parameter range from -1 to +1 in the function.
     In this case, incorrect return values occurred at parameter values of about 700.  
     These incorrect return values do not return the value 0, but high negative values.  
        **[Video with bar graph of the return values](video/cirtic_values2.mp4?raw=true)**
