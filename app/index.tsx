import { View, Image } from 'react-native';
import { Text } from '@/components/ui/text';
import { SafeAreaView } from 'react-native-safe-area-context';


export default function Screen() {
  return (
    <SafeAreaView>
      <View className='h-full'>
        <View className='flex-1 w-full flex items-center justify-center gap-3'>
          <Image source={require('../assets/images/logo.png')} className='w-40 h-40 rounded' />
          <Text className='text-lg font-extrabold'>SAM</Text>
        </View>
        <View>
          <Text className='text-center text-xs'>All in one student companion</Text>
          <Text className='text-center text-xs'>version: 0.2.0</Text>
        </View>
      </View>
    </SafeAreaView>
  );
}


