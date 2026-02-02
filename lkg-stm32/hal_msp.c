// clang-format off

#include <LkgLib.h>

extern DMA_HandleTypeDef hdma_adc1;
extern ADC_HandleTypeDef hadc1;
extern ADC_HandleTypeDef hadc2;

void ADC1_2_IRQHandler(void);
void DMA1_Channel1_IRQHandler(void);

void HAL_ADC_MspInit(ADC_HandleTypeDef* hadc)
{
    LKG_ADC_MspInit(hadc);
}

void HAL_ADC_MspDeInit(ADC_HandleTypeDef* hadc)
{
    LKG_ADC_MspDeInit(hadc);
}
