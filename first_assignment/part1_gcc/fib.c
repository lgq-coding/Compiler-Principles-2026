#include <stdio.h>

int getint(void);
void putint(int value);
void putch(int value);

int main()
{
    int a, b, i, n, t;

    n = getint();

    a = 0;
    b = 1;
    i = 1;

    putint(a);
    putch(10);
    putint(b);
    putch(10);

    while (i < n)
    {
        t = b;
        b = a + b;
        putint(b);
        putch(10);
        a = t;
        i = i + 1;
    }

    return 0;
}
