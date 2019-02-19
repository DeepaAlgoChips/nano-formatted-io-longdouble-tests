#include <stdio.h>
long double ld = 0.1234567890123456789012345678;
long double l_suffix = 0.1234567890123456789012345678L;
int main (void)
{
  printf ("ld = %.30Lf\n", ld);
  printf ("l_suffix = %.30Lf\n", l_suffix);
  return 0;
}
