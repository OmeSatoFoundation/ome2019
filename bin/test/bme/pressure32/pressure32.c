#include <stdint.h>
#include <stdio.h>

typedef uint32_t BME280_U32_t; 
typedef int32_t  BME280_S32_t; 
typedef uint64_t BME280_U64_t; 
typedef int64_t  BME280_S64_t; 

BME280_S32_t t_fine = 173492;

unsigned short dig_T1 = 27875;
signed short dig_T2 = 26642;
signed short dig_T3 = 50;
unsigned short dig_P1 = 36478;
signed short dig_P2 = -10481;
signed short dig_P3 = 3024;
signed short dig_P4 = 8926;
signed short dig_P5 = -73;
signed short dig_P6 = -7;
signed short dig_P7 = 12300;
signed short dig_P8 = -12000;
signed short dig_P9 = 5000;
unsigned char dig_H1 = 75;
signed short dig_H2 = 331;
unsigned char dig_H3 = 0;
signed short dig_H4 = 401;
signed short dig_H5 = 50;
signed char dig_H6 = 30;

BME280_U32_t BME280_compensate_P_int32(BME280_S32_t adc_P) {
  BME280_S32_t var1, var2;
  BME280_U32_t p;
  var1 = (((BME280_S32_t)t_fine) >> 1) -(BME280_S32_t)64000;
  printf("%d\n", var1);
  var2 = (((var1 >> 2) * (var1 >> 2)) >> 11) * ((BME280_S32_t)dig_P6);
  printf("%d\n", var2);
  var2 = var2 + ((var1 * ((BME280_S32_t)dig_P5)) << 1);
  printf("%d\n", var2);
  var2 = (var2 >> 2) + (((BME280_S32_t)dig_P4) << 16);
  printf("%d\n", var2);
  var1 = (((dig_P3 * (((var1 >> 2) * (var1 >> 2)) >> 13)) >> 3) +
          ((((BME280_S32_t)dig_P2) * var1) >> 1)) >>
         18;
  printf("%d\n", var1);
  var1 = ((((32768 + var1)) * ((BME280_S32_t)dig_P1)) >> 15);
  printf("%d\n", var1);
  if (var1 == 0) {
    return 0; // avoid exception caused by division by zero
  }
  p = (((BME280_U32_t)(((BME280_S32_t)1048576) - adc_P) - (var2 >> 12))) * 3125;
  printf("%d\n", p);
  if (p < 0x80000000) {
    p = (p << 1) / ((BME280_U32_t)var1);
  } else {
    p = (p / (BME280_U32_t)var1) * 2;
  }
  printf("%d\n", p);
  var1 = (((BME280_S32_t)dig_P9) *
          ((BME280_S32_t)(((p >> 3) * (p >> 3)) >> 13))) >>
         12;
  printf("%d\n", var1);
  var2 = (((BME280_S32_t)(p >> 2)) * ((BME280_S32_t)dig_P8)) >> 13;
  printf("%d ===\n", var2);
  p = (BME280_U32_t)((BME280_S32_t)p + ((var1 + var2 + dig_P7) >> 4));
  printf("%d\n", p);
  return p;
}

int main(void) {
  BME280_S32_t adc_P = 340728;
  BME280_S32_t pressure = BME280_compensate_P_int32(adc_P);
  printf("%f\n", pressure / (double)100);
}
