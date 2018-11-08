# Using Lightworks special auto-synced parameters

[The available variables, which Lightworks automatically updates with the project, can be found in chapter "Basics".  ]../(Code_for_developing_Lightworks_effects/blob/master/Basics/Variables_etc/Auto_synced/README.md)


### Calculation of the project frame rate
This macro "PROJECTfps" calculates the actual frame rate of the project.
This may differ from the automatically synchronized variable "float _OutputFPS", which passes the framerate set in the project settings "Video / Output / Format".  

```` Code
//--------------------------------------------------------------//
// Definitions, declarations und macros
//--------------------------------------------------------------//

float _Length;
float _LengthFrames; 

#define PROJECTfps   (_LengthFrames / _Length)
````