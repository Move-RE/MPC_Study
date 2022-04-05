

/*
 * Include Files
 *
 */
#if defined(MATLAB_MEX_FILE)
#include "tmwtypes.h"
#include "simstruc_types.h"
#else
#include "rtwtypes.h"
#endif

/* %%%-SFUNWIZ_wrapper_includes_Changes_BEGIN --- EDIT HERE TO _END */

#include <math.h>
/* %%%-SFUNWIZ_wrapper_includes_Changes_END --- EDIT HERE TO _BEGIN */
#define u_width 35
#define y_width 1
/*
 * Create external references here.  
 *
 */
/* %%%-SFUNWIZ_wrapper_externs_Changes_BEGIN --- EDIT HERE TO _END */

/* extern double func(double a); */
/* %%%-SFUNWIZ_wrapper_externs_Changes_END --- EDIT HERE TO _BEGIN */

/*
 * Output functions
 *
 */
void state_space_c_Outputs_wrapper(const real_T *u0,
			real_T *y0,
			const real_T *xC)
{
/* %%%-SFUNWIZ_wrapper_Outputs_Changes_BEGIN --- EDIT HERE TO _END */

/* This sample sets the output equal to the input
          y0[0] = u0[0];
 For complex signals use: y0[0].re = u0[0].re;
                          y0[0].im = u0[0].im;
                          y1[0].re = u1[0].re;
                          y1[0].im = u1[0].im;*/
 y0[0]=xC[0];
 y0[1]=xC[1];
 y0[2]=xC[2];
 y0[3]=xC[3];
 y0[4]=xC[4];
 y0[5]=xC[5];
 y0[6]=((-(xC[1]*xC[3]) + xC[0]*xC[4] - xC[3]*xC[5]*u0[6] - xC[4]*xC[5]*u0[7] +  u0[2]/u0[15] + (pow(xC[3],2) + pow(xC[4],2))*u0[8])*(u0[17] ))/u0[34]+((u0[0]/u0[15] - xC[2]*xC[4] + xC[1]*xC[5] +  (pow(xC[4],2) + pow(xC[5],2))*u0[6] - xC[3]*xC[4]*u0[7] - xC[3]*xC[5]*u0[8])*(u0[16]))/u0[34]+((u0[18])*(u0[4] - u0[13]*pow(xC[3],2) - u0[14]*xC[3]*xC[4] - u0[9]*xC[3]*xC[5] +  u0[12]*xC[4]*xC[5] + u0[11]*xC[4]*xC[5] + u0[13]*pow(xC[5],2) + u0[15]*(xC[1]*xC[3] - xC[0]*xC[4])*u0[6] - u0[15]*(xC[2]*xC[4] - xC[1]*xC[5])*u0[8]))/u0[34];
/* %%%-SFUNWIZ_wrapper_Outputs_Changes_END --- EDIT HERE TO _BEGIN */
}

/*
  *  Derivatives function
  *
  */
void state_space_c_Derivatives_wrapper(const real_T *u0,
			real_T *y0,
			real_T *dx,
			real_T *xC)
{
/* %%%-SFUNWIZ_wrapper_Derivatives_Changes_BEGIN --- EDIT HERE TO _END */

/*
  * Code example
  *   dx[0] = xC[0];
 */
 dx[0]=((-(xC[1]*xC[3]) + xC[0]*xC[4] - xC[3]*xC[5]*u0[6] - xC[4]*xC[5]*u0[7] +  u0[2]/u0[15] + (pow(xC[3],2) + pow(xC[4],2))*u0[8])*(u0[17] ))/u0[34]+((u0[0]/u0[15] - xC[2]*xC[4] + xC[1]*xC[5] +  (pow(xC[4],2) + pow(xC[5],2))*u0[6] - xC[3]*xC[4]*u0[7] - xC[3]*xC[5]*u0[8])*(u0[16]))/u0[34]+((u0[18])*(u0[4] - u0[13]*pow(xC[3],2) - u0[14]*xC[3]*xC[4] - u0[9]*xC[3]*xC[5] +  u0[12]*xC[4]*xC[5] + u0[11]*xC[4]*xC[5] + u0[13]*pow(xC[5],2) + u0[15]*(xC[1]*xC[3] - xC[0]*xC[4])*u0[6] - u0[15]*(xC[2]*xC[4] - xC[1]*xC[5])*u0[8]))/u0[34];
 dx[1]=((xC[2]*xC[3] - xC[0]*xC[5] - xC[3]*xC[4]*u0[6] + u0[1]/u0[15] + (pow(xC[3],2) + pow(xC[5],2))*u0[7] - xC[4]*xC[5]*u0[8])*(u0[19] ))/u0[34]+((u0[20])*(u0[3] + u0[13]*xC[3]*xC[4] + u0[14]*pow(xC[4],2) - u0[12]*xC[3]*xC[5]+  u0[10]*xC[4]*xC[5] - u0[11]*xC[4]*xC[5] - u0[14]*pow(xC[5],2) - u0[15]*(xC[1]*xC[3] - xC[0]*xC[4])*u0[7] + u0[15]*(-(xC[2]*xC[3]) + xC[0]*xC[5])*u0[8]))/u0[34]+ ((u0[21])*(u0[5] + u0[12]*pow(xC[3],2) + u0[9]*xC[3]*xC[4] - u0[10]*xC[3]*xC[4] - u0[12]*pow(xC[4],2) + u0[14]*xC[3]*xC[5] - u0[13]*xC[4]*xC[5] - u0[15]*(-(xC[2]*xC[3]) + xC[0]*xC[5])*u0[6] + u0[15]*(xC[2]*xC[4] - xC[1]*xC[5])*u0[7]))/u0[34];
 dx[2]=((-(xC[1]*xC[3]) + xC[0]*xC[4] - xC[3]*xC[5]*u0[6] - xC[4]*xC[5]*u0[7] +  u0[2]/u0[15] + (pow(xC[3],2) + pow(xC[4],2))*u0[8])*(u0[23] ))/u0[34]+((u0[0]/u0[15] - xC[2]*xC[4] + xC[1]*xC[5] +  (pow(xC[4],2) + pow(xC[5],2))*u0[6] - xC[3]*xC[4]*u0[7] - xC[3]*xC[5]*u0[8])*(u0[22]))/u0[34]+ ((u0[24])*(u0[4] - u0[13]*pow(xC[3],2) - u0[14]*xC[3]*xC[4] - u0[9]*xC[3]*xC[5] +  u0[12]*xC[4]*xC[5] + u0[11]*xC[4]*xC[5] + u0[13]*pow(xC[5],2) + u0[15]*(xC[1]*xC[3] - xC[0]*xC[4])*u0[6] - u0[15]*(xC[2]*xC[4] - xC[1]*xC[5])*u0[8]))/u0[34];
 dx[3]=((xC[2]*xC[3] - xC[0]*xC[5] - xC[3]*xC[4]*u0[6] + u0[1]/u0[15] + (pow(xC[3],2) + pow(xC[5],2))*u0[7] - xC[4]*xC[5]*u0[8])*(u0[25]))/u0[34]+((u0[26])*(u0[3] + u0[13]*xC[3]*xC[4] + u0[14]*pow(xC[4],2) - u0[12]*xC[3]*xC[5]+  u0[10]*xC[4]*xC[5] - u0[11]*xC[4]*xC[5] - u0[14]*pow(xC[5],2) - u0[15]*(xC[1]*xC[3] - xC[0]*xC[4])*u0[7] + u0[15]*(-(xC[2]*xC[3]) + xC[0]*xC[5])*u0[8]))/u0[34] +((u0[27])*(u0[5] + u0[12]*pow(xC[3],2) + u0[9]*xC[3]*xC[4] - u0[10]*xC[3]*xC[4] - u0[12]*pow(xC[4],2) + u0[14]*xC[3]*xC[5] - u0[13]*xC[4]*xC[5] - u0[15]*(-(xC[2]*xC[3]) + xC[0]*xC[5])*u0[6] + u0[15]*(xC[2]*xC[4] - xC[1]*xC[5])*u0[7]))/u0[34];
 dx[4]= ((-(xC[1]*xC[3]) + xC[0]*xC[4] - xC[3]*xC[5]*u0[6] - xC[4]*xC[5]*u0[7] +  u0[2]/u0[15] + (pow(xC[3],2) + pow(xC[4],2))*u0[8])*(u0[29]))/u0[34]+((u0[0]/u0[15] - xC[2]*xC[4] + xC[1]*xC[5] +  (pow(xC[4],2) + pow(xC[5],2))*u0[6] - xC[3]*xC[4]*u0[7] - xC[3]*xC[5]*u0[8])*(u0[28]))/u0[34]+((u0[30])*(u0[4] - u0[13]*pow(xC[3],2) - u0[14]*xC[3]*xC[4] - u0[9]*xC[3]*xC[5] +  u0[12]*xC[4]*xC[5] + u0[11]*xC[4]*xC[5] + u0[13]*pow(xC[5],2) + u0[15]*(xC[1]*xC[3] - xC[0]*xC[4])*u0[6] - u0[15]*(xC[2]*xC[4] - xC[1]*xC[5])*u0[8]))/u0[34];
 dx[5]=((xC[2]*xC[3] - xC[0]*xC[5] - xC[3]*xC[4]*u0[6] + u0[1]/u0[15] + (pow(xC[3],2) + pow(xC[5],2))*u0[7] - xC[4]*xC[5]*u0[8])*(u0[31]))/u0[34]+((u0[32])*(u0[3] + u0[13]*xC[3]*xC[4] + u0[14]*pow(xC[4],2) - u0[12]*xC[3]*xC[5]+  u0[10]*xC[4]*xC[5] - u0[11]*xC[4]*xC[5] - u0[14]*pow(xC[5],2) - u0[15]*(xC[1]*xC[3] - xC[0]*xC[4])*u0[7] + u0[15]*(-(xC[2]*xC[3]) + xC[0]*xC[5])*u0[8]))/u0[34] +((u0[33] )*(u0[5] + u0[12]*pow(xC[3],2) + u0[9]*xC[3]*xC[4] - u0[10]*xC[3]*xC[4] - u0[12]*pow(xC[4],2) + u0[14]*xC[3]*xC[5] - u0[13]*xC[4]*xC[5] - u0[15]*(-(xC[2]*xC[3]) + xC[0]*xC[5])*u0[6] + u0[15]*(xC[2]*xC[4] - xC[1]*xC[5])*u0[7]))/u0[34];
/* %%%-SFUNWIZ_wrapper_Derivatives_Changes_END --- EDIT HERE TO _BEGIN */
}
