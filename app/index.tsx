import { View } from 'react-native';
import { Text } from '@/components/ui/text';
import { ThemeToggle } from '@/components/theme-toggle';


export default function Screen() {
  return (
    <>
      <ThemeToggle />
      <View className="flex-1 items-center justify-center gap-8 p-4">
        <Text>hehe</Text>
      </View>
    </>
  );
}


