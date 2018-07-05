# Color parameters

### Colour picker: 
``` Code
float4 TLColour
<
   string Description = "Top Left";
   bool SupportsAlpha = true;
> = { 1.0, 0.0, 0.0, 1.0 };
```  
You can use either standard brackets in that parameter to give you ( 1.0, 0.0, 0.0, 1.0 ) or curly brackets as shown above.  
If you use the standard brackets the colour shown will default to white,  
regardless of any values that you may have set in your code.

---  
  
### Colour wheel:
``` Code
float4 MidTintColour
<
   string Description = "Midtones";
   string Group       = "Tonal Ranges";
   string Flags       = "SpecifiesColourOffset";
> = ( 1.0, 1.0, 1.0, 1.0 );
```
   
