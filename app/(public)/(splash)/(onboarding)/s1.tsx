import { Button } from "@/components/ui/button";
import { Icon } from "@/components/ui/icon";
import { Text } from "@/components/ui/text";
import { View, Image, useWindowDimensions } from "react-native";
import { ArrowRight } from 'lucide-react-native';

const Onboarding1 = () => {
  const { height, width } = useWindowDimensions()
  return (
    <View style={{ height: height }}>
      <View className="flex-row justify-end">
        <Button variant="ghost">
          <Text className="font-outfit">Skip</Text>
        </Button>
      </View>

      <View className="flex-1 flex-col gap-5 items-center justify-center">
        <Image
          source={require('../../../../assets/images/logo.png')}
          style={{ height: height * 0.5, width: width * 0.9 }}
          className="rounded"
        />
        <Text className="text-center font-outfit-bold text-2xl" style={{ width: width * 0.8 }}>All your academics in one place</Text>
        <View style={{ width: width * 0.8 }}>
          <Text className="text-center font-outfit-light mx-5">track your cgpa in real tim, plan target semesters and keep all curriculum resources right at your finger tips.</Text>
        </View>

        <Button className="w-full">
          <Text>Next</Text>
          <Icon as={ArrowRight} />
        </Button>
      </View>
    </View>
  )
}

export default Onboarding1;
