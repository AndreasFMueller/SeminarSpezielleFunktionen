#include <math.h>

/**
  * @brief Calculates pochhammer
  * @param (a+n-1)!
  * @return Result
  */
static double pochhammer(const double x, double n)
{
    double temp = x;

    if (n > 0)
    {
        while (n > 1)
        {
            temp *= (x + n - 1);
            --n;
        }

        return temp;
    }
    else
    {
        return 1;
    }
}

/**
  * @brief Calculates the Factorial
  * @param n!
  * @return Result
  */
static double fac(int n)
{
    double temp = n;

    if (n > 0)
    {
        while (n > 1)
        {
            --n;
            temp *= n;
        }
        return temp;
    }
    else
    {
        return 1;
    }
}

/**
  * @brief Calculates the Hypergeometric Function 0F1(;b;z)
  * @param c in 0F1(;c;z)
  * @param z in 0F1(;c;z)
  * @param n number of itertions (precision)
  * @return Result
  */
static double powerseries(const double c, const double z, unsigned int n)
{
    double temp = 0.0;

    for (unsigned int k = 0; k < n; ++k)
    {
        temp += pow(z, k) / (factorial(k) * pochhammer(c, k));
    }

    return temp;
}