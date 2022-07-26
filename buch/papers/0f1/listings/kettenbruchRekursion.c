/**
  * @brief Calculates the Hypergeometric Function 0F1(;c;z)
  * @param c in 0F1(;c;z)
  * @param z in 0F1(;c;z)
  * @param k number of itertions (precision)
  * @return Result
  */
static double fractionIter0f1(const double c, const double z, unsigned int k)
{
    //declaration
    double a = 0.0;
    double b = 0.0;
    double abk = 0.0;
    double temp = 0.0;

    for (; k > 0; --k)
    {
        abk = z / (k * ((k - 1) + c));  //abk = ak, bk
        
        a = k > 1 ? (1 + abk) : 1;  //a0, a1
        b = k > 1 ? -abk : abk;     //b1

        temp = b / (a + temp);      ////bk / (ak + last result)
    }

    return a + temp;   //a0 + temp
}