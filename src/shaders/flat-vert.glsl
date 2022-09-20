#version 300 es
precision highp float;
uniform float u_Time;
// The vertex shader used to render the background of the scene
uniform mat4 u_Model;       // The matrix that defines the transformation of the
                            // object we're rendering. In this assignment,
                            // this will be the result of traversing your scene graph.

uniform mat4 u_ModelInvTr;  // The inverse transpose of the model matrix.
                            // This allows us to transform the object's normals properly
                            // if the object has been non-uniformly scaled.

uniform mat4 u_ViewProj;    // The matrix that defines the camera's transformation.
                            // We've written a static matrix for you to use for HW2,
                            // but in HW3 you'll have to generate one yourself

in vec4 vs_Pos;             // The array of vertex positions passed to the shader

in vec4 vs_Nor;             // The array of vertex normals passed to the shader

in vec4 vs_Col;             // The array of vertex colors passed to the shader.

out vec4 fs_Pos;
out vec4 fs_Nor;            // The array of normals that has been transformed by u_ModelInvTr. This is implicitly passed to the fragment shader.
out vec4 fs_LightVec;       // The direction in which our virtual light lies, relative to each vertex. This is implicitly passed to the fragment shader.
out vec4 fs_Col;            // The color of each vertex. This is implicitly passed to the fragment shader.

const vec4 lightPos = vec4(5, 5, 3, 1); //The position of our virtual light, which is used to compute the shading of
                                        //the geometry in the fragment shader.


// float randNoise(vec4 norm){
//     float r = 0.25 * (cos(norm.x) + sin(norm.y));
//     return r;
// }

// float lerp(float a, float b, float t) {
//   return t * a + (1.0 - t) * b;
// }

// float sfrand( int seed )
// {
//     int a = seed & 32767;
//     return( 0.25f + (2.0f/32767.0f) * float(a) );
// }

// float noise3D(vec3 seed_var) {
//     float r = 0.0;

//     return r;
// }

void main() {

    fs_Col = vs_Col;                         // Pass the vertex colors to the fragment shader for interpolation
    
    mat3 invTranspose = mat3(u_ModelInvTr);
    fs_Nor = vec4(invTranspose * vec3(vs_Nor), 0);          // Pass the vertex normals to the fragment shader for interpolation.
                                                            // Transform the geometry's normals by the inverse transpose of the
                                                            // model matrix. This is necessary to ensure the normals remain
                                                            // perpendicular to the surface after the surface is transformed by
                                                            // the model matrix.

    vec4 modelposition = u_Model * vs_Pos; //(vs_Pos -  vec4(1.0) * sin(u_Time * 0.05));   // Temporarily store the transformed vertex positions for use below
    //modelposition += sfrand(int(vs_Nor.x)) * vs_Nor * sin(u_Time * 0.05);
    //fs_LightVec = lightPos - modelposition;  // Compute the direction in which the light source lies

    fs_Pos = modelposition;
    //gl_Position = u_ViewProj * modelposition;
    gl_Position = u_ViewProj * vs_Pos;
}
