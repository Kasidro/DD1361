
#include <stdio.h>

int main(int argc, const char *argv[])
{
    long long aLongLong1,
              aLongLong2;

    unsigned int aUInt1,
                 aUInt2;

    char someChars[5];

    double aDouble;

    printf("%-13s  %-10s  %-20s  %-20s\n", "Name", "Value", "Adress", "Size");

    printf("%-13s  %-10lld  %-20p  %-20lu\n", "aLongLong1", aLongLong1, &aLongLong1, sizeof(aLongLong1));
    printf("%-13s  %-10lld  %-20p  %-20lu\n", "aLongLong2", aLongLong2, &aLongLong2, sizeof(aLongLong2));

    printf("%-13s  %-10u  %-20p  %-20lu\n", "dUInt1", aUInt1, &aUInt1, sizeof(aUInt1));
    printf("%-13s  %-10u  %-20p  %-20lu\n", "dUInt2", aUInt2, &aUInt2, sizeof(aUInt2));

    printf("%-13s  %-10s  %-20p  %-20lu\n", "someChars", someChars, &someChars, sizeof(someChars));

    printf("%-13s  %-10.5f  %-20p  %-20lu\n", "aDouble", aDouble, &aDouble, sizeof(aDouble));

    return 0;
}
