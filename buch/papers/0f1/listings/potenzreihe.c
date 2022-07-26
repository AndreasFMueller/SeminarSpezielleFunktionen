#include <math.h>

static double powerseries(const double b, const double z, unsigned int n)
{
    double temp = 0.0;

    for (unsigned int k = 0; k < n; ++k)
    {
        temp += pow(z, k) / (factorial(k) * pochhammer(b, k));
    }

    return temp;
}