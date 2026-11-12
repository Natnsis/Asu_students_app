import { View, Image } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import Onboarding1 from './(public)/(splash)/(onboarding)/s1';


export default function Screen() {
  return (
    <SafeAreaView>
      <View className='h-full'>
        <Onboarding1 />
      </View>
    </SafeAreaView>
  );
}


