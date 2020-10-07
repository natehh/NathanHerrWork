#include <stdio.h>
#include <stdlib.h>
#include <math.h>

float RK_accel(float v, float F1, float F2, float mass)
{
    float yout;
    yout = (F1+F2)/mass;
    return yout;

}
