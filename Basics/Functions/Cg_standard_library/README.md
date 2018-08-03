## Cg standard functions (Intrinsic Functions)

For details see the PDF document: [Nvidia's Cg reference manual, starting on page 685](https://www.google.com.au/url?sa=t&rct=j&q=&esrc=s&source=web&cd=3&cad=rja&uact=8&ved=0ahUKEwj5qpif6rHTAhXLF5QKHQ6MCeAQFggwMAI&url=http%3A%2F%2Fdeveloper.download.nvidia.com%2Fcg%2FCg_3.1%2FCg-3.1_April2012_ReferenceManual.pdf&usg=AFQjCNHI5gaVpuvJH6ZO8bnX7BxJGKXr0A)  

With regard to the parameters, please note the permissible scalar and vector types.  
Also note which combinations of these types of types are allowed. Deviating from this can lead to unexpected results and reduce compatibility.
Also **avoid** the special types listed in the Cg manual, such as `half`, `fixed` , etc.  
Not all of the features listed there are available in Lightworks or across platforms.

---

### Thematic overview of helpful functions:

   
#### Loads color values from the sampler:
   - **`tex2D`**   **This most important function is needed in almost all effects.**  
   There are similar tex .. functions. Whether these are useful for Lightworks is questionable ....
   - For example: **`tex2Dbias`** [Test see lwks.com](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=75&Itemid=81#151431)
   

#### Limit values
   - **`clamp`**     Clamps the specified value to the specified minimum and maximum range.
   - **`max`**       returns the maximum of two scalars or each respective component of two vecto.
   - **`min`**       returns the minimum of two scalars or each respective component of two vectors.
   - **`saturate`**  Clamps the specified value within the range of 0 to 1.


#### Integer and/or floating-point manipulations:

   - **`abs`**     returns absolute value of scalars and vectors.  
   - **`ceil`**    ?? would be to investigate; seems to be the same as round ()?.
   - **`floor`**   Returns a floating-point type where all digits to the right of the decimal point are 0. 
   - **`fmod`**    returns the remainder of x/y with the same sign as x.
   - **`frac`**    returns the fractional portion of a scalar or each vector component. 
   - **`modf`**    decompose a ﬂoat into integer and fractional parts.
   - **`round`**   returns the rounded value of scalars or vectors. [Problems reported, see lwks.com post#172865](https://www.lwks.com/index.php?option=com_kunena&func=view&catid=7&id=143678&limit=15&limitstart=255&Itemid=81#172865)

   
#### Jumping to zero or 1 etc.
   - **`sign`**        returns sign of scalar or each vector component.
   - **`smoothstep`**  interpolate smoothly between two input values based on a third.
   - **`step`**         Compares two values, returning 0 or 1 based on which value is greater
   
   
#### General mathematical functions:
   - **`exp`**     returns the base-e exponential of scalars and vectors.
   - **`exp2`**    returns the base-2 exponential of scalars and vectors.
   - **`log`**     returns the natural logarithm of scalars and vectors.
   - **`log10`**   returns the base-10 logarithm of scalars and vectors.
   - **`log2`**    returns the base-2 logarithm of scalars and vectors.
   - **`pow`**    returns x to the y-th power of scalars and vectors.
   - **`rsqrt`**  returns reciprocal square root of scalars and vectors.
   - **`sqrt`**   returns square root of scalars and vectors.  


#### Trigonometry, circles etc.:
   - **`acos`**     returns arccosine of scalars and vectors.  
   - **`asin`**     returns arcsine of scalars and vectors. 
   - **`atan`**     returns arctangent of scalars and vector.
   - **`atan2`**    returns arctangent of scalars and vectors.
   - **`cos`**      returns cosine of scalars and vectors.
   - **`cosh`**     returns hyperbolic cosine of scalars and vectors.
   - **`degrees`**  converts values of scalars and vectors from radians to degrees.
   - **`radians`**  converts values of scalars and vectors from degrees to radians
   - **`sin`**      returns sine of scalars and vectors.
   - **`sincos`**   returns the sine and cosine of scalars and vectors.
   - **`sinh`**     returns hyperbolic sine of scalars and vectors.
   - **`tan`**      returns tangent of scalars and vectors.
   - **`tanh`*      returns hyperbolic tangent of scalars and vectors.


#### Mainly for color vectors:
   - **`lerp`** returns linear interpolation of two scalars or vectors based on a weight.
   
   
#### Mainly for position and direction vectors:
   - **`distance`**   return the Euclidean distance between two points.
   - **`dot`**        returns the scalar dot product of two vector
   - **`length`**     return scalar Euclidean length of a vector
   - **`normalize`**  normalizes a vector
   

   
---
---


### Miscellaneous (function in Lightworks may be uncertain or untested):
   - `all` Problems reported (details unknown so far)  
      - It should be checked whether the function was used according to their specifications in these problem cases.
   - `any` Problems reported (details unknown so far)  
      - It should be checked whether the function was used according to their specifications in these problem cases.
   - `clip`  conditionally kill a pixel before output
   - `cross` returns the cross product of two three-component vectors
   - `ddx`   returns approximate partial derivative with respect to window-space X
   - `ddy`   returns approximate partial derivative with respect to window-space Y
   - `determinant`  return the scalar determinant of a square matrix 
   - `faceforward` ???
   - `frexp` splits scalars and vectors into normalized fraction and a power of 2
   - `fwidth`  returns sum of approximate window-space partial derivatives magnitudes.
   - `isﬁnite` test whether or not a scalar or each vector component is a ﬁnite value.
   - `isinf` test whether or not a scalar or each vector component is inﬁnite.
   - `isnan` test whether or not a scalar or each vector component is not-a-number
   - `ldexp`  returns x times 2 raised to the power n.
   - `lit`   computes lighting coefﬁcients for ambient, diffuse, and specular lighting contribution
   - `mul`   multiply a matrix by a column vector, row vector by a matrix, or matrix by a matrix
   - `reﬂect` returns the reﬂectiton vector given an incidence vector and a normal vector.
   - `refract` computes a refraction vector.
   - `transpose` returns transpose matrix of a matrix.
   - `trunc` Returns the integral value nearest to but no larger in magnitude than the parameter.
