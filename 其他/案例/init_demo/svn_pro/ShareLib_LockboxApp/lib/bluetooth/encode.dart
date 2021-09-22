import 'dart:typed_data';

const START_ADDRESS = 0xAA;
const DEVICE_TYPE = 0x06;
const MASTER_DEVICE = 0x10;

const SL_START_CHAR = 0x01;
const SL_ESC_CHAR = 0x02;
const SL_END_CHAR = 0x03;

int sendOneByte(bool bSpecialCharacter, int temp ,List<int> outData)
{
  if(!bSpecialCharacter && (temp < 0x10))
  {
    /* Send escape character and escape byte */
    outData.add(SL_ESC_CHAR);
    outData.add(temp ^ 0x10);
    return 2;
  }
  else
  {
    outData.add(temp);
    return 1;
  }
}


int calculateCRC(int u8Start, int deviceType, List<int> outData,int size)
{
  int n;
  int crcSumValue;
  
  crcSumValue = u8Start;
  crcSumValue ^= deviceType;
  
  for (n = 0; n < size; n++)
  {
    crcSumValue ^= outData[n];
  }
  return crcSumValue;
}


void sendMessage(int deviceType, Uint8List inData, List<int> outData) {
  int size = inData.length;
  
  int Crc = calculateCRC(0xaa,deviceType,inData ,size);
  
  int length = 0;
  
  /* Send start character */
  length += sendOneByte(true, SL_START_CHAR,outData);
  
  /* Send start address code  */
  length += sendOneByte(false, START_ADDRESS,outData);
  
  /* Send Device type  */
  length += sendOneByte(false, deviceType,outData);
  
  /* Send message checksum */
  length += sendOneByte(false,Crc,outData);
  
  for(int i = 0;i < size;i++)
  {
    length += sendOneByte(false, inData[i] ,outData);
  }
  /* Send end character */
  length += sendOneByte(true, SL_END_CHAR, outData);
}

void encode() {
  
}