# Scalar parameter

First, a **default code** from the "negative.fx" effect, as used in the introduction on [redsharknews.com](https://www.redsharknews.com/technology/item/221-how-to-write-video-effects-for-lightworks)
``` Code
float Level
<
   string Description = "Level";
   string Group = "Threshold";
   float MinVal = 0.0;
   float MaxVal = 1.0;
> = 0.0;

float Softness
<
   string Description = "Softness";
   string Group = "Threshold";
   float MinVal = 0.0;
   float MaxVal = 1.0;
> = 0.25;
```


### The result:
![](images/negative.png)

---

### Automatic keyframes at the start and end position of the effect `KF0`and `KF1`:

``` Code
float Amount
<
   string Description = "Amount";
   float MinVal = 0.0;
   float MaxVal = 1.0;
   float KF0    = 0.0;
   float KF1    = 1.0;
> = 0.5;

``` 

-- 

### Parameter influence via moving mouse position on the viewer:
`Flags = "SpecifiesPointX";` and `Flags = "SpecifiesPointY";`  
 optional: `Flags = "SpecifiesPointZ";`

``` Code
float CentreX
<
   string Description = "Origin";
   string Flags = "SpecifiesPointX";
   float MinVal = 0.00;
   float MaxVal = 1.00;
> = 0.5;

float CentreY
<
   string Description = "Origin";
   string Flags = "SpecifiesPointY";
   float MinVal = 0.00;
   float MaxVal = 1.00;
> = 0.5;
``` 

**Additional information:** when using "SpecifiesPointY" it may be necessary to invert the sense of the value returned.
   In the example above float Centre_Y = 1.0 - CentreY will do that.
   You then use Centre_Y in your code instead of CentreY.

   There's also a third parameter in this group, "SpecifiesPointZ".
   To see that being used look at the position parameters in the 3D DVE effect. 
   
--- 


``` Code
``` 


