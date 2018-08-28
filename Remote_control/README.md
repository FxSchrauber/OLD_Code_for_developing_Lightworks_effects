# Remote control of effects settings.


Usage: Texture output (and input) to pass a scalar values etc to other effects in the routing.

Note that the codes were developed at a time when the effects typically only output 8-bit RGBA values. With Lightworks 14.5, higher precision can also be set.

---

## [Channel definitions](Channel_definitions/README.md)

---

## [Receiver](Receiver/README.md)  

---

## Transmitter
* **Red and green color channel:** Coded value to increase precision.  
   ``` code
   float green = frac(original_value * 255.0);
   float red   = original_value - green / 255.0;
   ```
* **Blue color channel:** [Status information](Channel_definitions/Channel_assignment.md#blue-color-channel-status-messages)  
* **Alpha channel:** Uncoded original value (precision according to the GPU precision setting)  
  
* **Position of the RGBA signal in the texture:** [Depends on the remote control channel.](Channel_definitions/README.md)  

---

## Test effect to test the precision of transmission of coded values.
  * Test effect code: ["Measuring the difference, Remote control precision measurement.fx"](Measuring%20the%20difference%2C%20Remote%20control%20precision%20measurement.fx)  
  * [Download as a .zip file](Measuring%20the%20difference%2C%20Remote%20control%20precision%20measurement.zip)  
