#ifndef LKG_LIB_H
#define LKG_LIB_H

#include <Arduino.h>

#ifdef __cplusplus
class LkgLib {
public:
    static LkgLib& getInstance(uint32_t buildnum, char* fwver) {
        // The instance is created only the first time this function is called.
        // C++11 guarantees this is thread-safe.
        static LkgLib instance(buildnum, fwver); 
        return instance;
    }
    
    void setup();
    void loop();
    uint32_t get_buildnum();
    char* get_fwver();
    
    // Delete Copy Constructor and Assignment Operator
    // This prevents users from accidentally making copies of your Singleton.
    LkgLib(const LkgLib&) = delete;
    void operator=(const LkgLib&) = delete;

  private:
    uint32_t _buildnum;
    char* _fwver;
    //Private constructor accepts the arguments
    LkgLib(uint32_t buildnum, char* fwver) {
        _buildnum = buildnum;
	_fwver = fwver;
    }
};
#endif

#ifdef __cplusplus
extern "C" {
#endif
void LKG_ADC_MspInit(ADC_HandleTypeDef *hadc);
void LKG_ADC_MspDeInit(ADC_HandleTypeDef *hadc);
#ifdef __cplusplus
}
#endif

#endif // LKG_LIB_H
