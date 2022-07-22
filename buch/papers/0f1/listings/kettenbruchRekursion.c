static double fractionIter0f1(const double b0, const double z, unsigned int n)
{
    double a = 0.0;
    double b = 0.0;
    double abn = 0.0;
    double temp = 0.0;

    for (; n > 0; --n)
    {
        abn = z / (n * ((n - 1) + b0));  //abn = ak, bk
        
        a = n > 1 ? (1 + abn) : 1;  //a0, a1
        b = n > 1 ? -abn : abn;     //b1

        temp = b / (a + temp); 
    }

    return a + temp;   //a0 + temp
}