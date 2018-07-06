## Variables, Auto-synced parameters und Definitions, Swizzle operators

Variables that are declared outside of shaders, functions (and possibly macros) are available globally  
for all subsequent shaders within that effect and can not be changed by the shader.  
If these constants come from the user effect settings, or if they are auto-synced parameters,  
then the CPU may pass another value to the GPU (the effect) with the following frame. (e.g., keyframing).




### Available variable types:
- **float**  
  - The most important and native variable type.  
    Within a shader, apparently 32 bit floating point precision.  
    The precision of the shader output (RGBA values from 0 to 1) depends on the Lightworks version and the project settings.  
- int
- bool


