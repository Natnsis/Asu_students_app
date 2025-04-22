import { SignedIn, useUser } from '@clerk/clerk-expo';
import { Link, useRouter } from 'expo-router';
import { Text, View } from 'react-native';
import { SignOutButton } from '../components/SignOutButton';
import Ionicons from '@expo/vector-icons/Ionicons';
import React ,{  useEffect, useState }from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';


export default function Page() {
  const { user } = useUser();
  const router = useRouter();
  const [localFirstName, setLocalFirstName] = useState(''); 
  const [localDepartment, setLocalDepartment] = useState(''); 
  const [year, setyear] = useState(''); 
  const [id, setId] = useState('');

  useEffect(() => {
    const userData = async () => {
      try {
        const credentials = await AsyncStorage.getItem('asuCredentials');
        if (credentials) {
          const parsedCredentials = JSON.parse(credentials);
          setLocalFirstName(parsedCredentials?.fullName?.split(' ')[0] || ''); 
          setLocalDepartment(parsedCredentials?.department); 
          setyear(parsedCredentials?.year); 
          setId(parsedCredentials?.studentId); 
        }
      } catch (error) {
        console.error('Error checking credentials:', error);
      }
    };

    userData();
  }, []);
  
  return (
    <SignedIn>
      <View className="bg-ash flex-1">
        <View className='flex-row w-full bg-back justify-between pt-5 px-2 pb-5 text-center'>
          <View className='flex-row gap-3'>
            <Ionicons name="menu" size={36} color="black" />
            <Text className='w-[60vw] text-2xl font-extrabold capitalize'>Asu Students App</Text>
          </View>
          <View className='w-[20vw] bg-primary py-2 pl-2 rounded mr-2'>
            <SignOutButton />
          </View>
        </View>


        <View className="px-4 mt-5">
          <View className='bg-back p-5 rounded-2xl '>
            <Text className='w-fit text-2xl capitalize font-extrabold'>
              Welcome Back, {localFirstName}!
            </Text>
            <Text className='font-mono text-second mt-3 text-lg'>
              Track your academic progress and campus life all in one place
            </Text>
            <View className='flex-row justify-between items-center my-5 '>
              <Text className='bg-primary w-[15vw] text-center text-back py-1 px-1 rounded-full'>
                {localDepartment}
              </Text>
              <Text className='bg-primary w-[30vw] text-center text-back py-1 px-1 rounded-full'>
                {id}
              </Text>
              <Text className='bg-primary w-[25vw] text-center text-back py-1 px-1 rounded-full'>
                year: {year}
              </Text>
            </View>
          </View>
        </View>


      </View>
    </SignedIn>
  );
}