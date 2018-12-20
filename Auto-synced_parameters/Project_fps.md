## Calculation of the project frame rate
This macro `PROJECTfps` calculates the actual frame rate of the project.
This may differ from the automatically synchronized variable `float _OutputFPS`, which passes the framerate set in the project settings "Video / Output / Format".  
*Global for the entire effect (add outside and above all shaders and functions):*
```` Code
//--------------------------------------------------------------//
// Definitions, declarations und macros
//--------------------------------------------------------------//

float _Length;
float _LengthFrames; 

#define PROJECTfps   (_LengthFrames / _Length)
````