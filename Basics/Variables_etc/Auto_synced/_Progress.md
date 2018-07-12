# Auto-synced parameter `_Progress`  

*Great White wrote:*  
> At the moment, when you export a marked section, a new sequence is generated behind the scenes
> which contains only the relevant portion of your sequence,  and that is what is exported.  
> This will affect _progress if your marks are not coincident with cuts. 

This can cause the effect to change its export behavio.

---

### Tips:

Alternatively you can create a progress variable by means of keyframing:
``` Code
float progress
<
	string Description = "Progress";
	float MinVal = 0.0;
	float MaxVal = 1.0;
        float KF0    = 0.0;
        float KF1    = 1.0;
> = 0.0;
``` 

You can add this code to the other parameters, where the user settings are defined.  
This slider can be visible and adjustable for the user.

 If the adjustability is undesirable:
 This code can be used to prevent an inadvertent misadjustment:
 
``` Code
float progress
<
	string Group = "Effect progress: Do not alter in any way";
	string Description = "Progress";
	float MinVal = 1.0;	// The Min value is higher than the Max value to disable the slider.
	float MaxVal = 0.0;	// The Max value is lower than the Min value to disable the slider.
        float KF0    = 0.0;
        float KF1    = 1.0;
> = 0.0;
```
